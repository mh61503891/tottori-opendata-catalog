require 'nokogiri'

module TottoriOpenDataCatalog
  module Parser
    class << self
      def parse_index(string)
        doc = Nokogiri::HTML(string, nil, 'Shift_JIS')
        # collect
        name = doc.xpath('//title').text.strip
        anchors = doc.xpath('//a')
        categories = anchors.select do |a|
          a[:href].include?('forweb_bunrui')
        end.map do |a|
          { name: a.text.strip, link: a[:href].strip }
        end
        items = {
          name: name,
          categories: categories
        }
        items
      end

      def parse_list(string)
        doc = Nokogiri::HTML(string, nil, 'Shift_JIS')
        # collect
        items = doc.xpath('//table[@id="contentslist"]/tr[position() > 1]').map do |tr|
          tds = tr.children
          item = {
            name: tds[0].text.strip,
            link: tds[0].children[0][:href],
            formats: tds[1].text.strip,
            url: tds[2].children[0][:href],
            department: tds[3].text.strip,
            division: tds[4].text.strip
          }
        end
        # trim
        items.each do |item|
          if item[:formats]
            item[:formats].upcase!
            item[:formats] = item[:formats].split
          end
        end
        target = items.find do |item|
          item[:link] == 'list1_forweb/10EE759AAD20B54749257C68000A2845?OpenDocument'
        end
        target[:formats] = ['PDF'] if target
        items
      end

      def parse_record(string)
        doc = Nokogiri::HTML(string, nil, 'Shift_JIS')
        # collect
        item = doc.xpath('//form/div[@id="all"]').children.map do |e|
          case e.text.strip
          when /データ年次.*?：(.*)$/
            { updated_at: Regexp.last_match(1).strip }
          when /情報.*?：(.*)/
            { tags: Regexp.last_match(1).strip }
          when /再配布可否.*?：(.*)$/
            { redistribution_allowed: Regexp.last_match(1).strip }
          when /商用利用可否.*?：(.*)$/
            { commercial_use_allowed: Regexp.last_match(1).strip }
          when /テータ提供.*?：(.*)$/
            { provider: Regexp.last_match(1).strip }
          when /問い合わせ先電話番号.*?：(.*)$/
            { tel: Regexp.last_match(1).strip }
          when /内容.*?：(.*)$/
            { description: Regexp.last_match(1).strip }
          when /コメント.*?：(.*)$/
            { comment: Regexp.last_match(1).strip }
          end
        end.compact.inject(&:merge)
        # trim
        if item[:redistribution_allowed] == '○'
          item[:redistribution_allowed] = true
        end
        if item[:commercial_use_allowed] == '○'
          item[:commercial_use_allowed] = true
        end
        updated_at = item.delete(:updated_at)
        if updated_at
          updated_at.tr!('　', ' ')
          updated_at.tr!('０-９', '0-9')
        end
        unless updated_at.delete(' ').empty?
          date, repeat_rule_description = updated_at.split
          year, month, day = date.split('.')
        end
        item[:year]  = (year ? year.to_i : nil)
        item[:month] = (month ? month.to_i : nil)
        item[:day]   = (day ? day.to_i : nil)
        item[:repeat_rule] = {}
        item[:repeat_rule].merge!(
          case repeat_rule_description
          when /毎年度/
            { frequency: 'fiscal_yearly', interval: nil }
          when /毎年/
            { frequency: 'yearly', interval: nil }
          when /毎月/
            { frequency: 'monthly', interval: nil }
          when /毎週/
            { frequency: 'weekly', interval: nil }
          when /(\d)年度毎/
            { frequency: 'fiscal_yearly', interval: Regexp.last_match(1).to_i }
          when /(\d)年毎/
            { frequency: 'yearly', interval: Regexp.last_match(1).to_i }
          when /(\d)月毎/, /(\d)ヶ月毎/
            { frequency: 'monthly', interval: Regexp.last_match(1).to_i }
          when /(\d)週毎/
            { frequency: 'weekly', interval: Regexp.last_match(1).to_i }
          when /随時/
            { frequency: 'as_needed', interval: nil }
          when /不定期/
            { frequency: 'unscheduled', interval: nil }
          when /予算編成時/
            { frequency: 'budgeting', interval: nil }
          else
            { frequency: nil, interval: nil }
        end)
        item[:repeat_rule].merge!(description: repeat_rule_description)
        # 繰り返しルールの説明が有るのに周期が無い場合は例外をスロー
        if !item[:repeat_rule][:description].nil? && item[:repeat_rule][:frequency].nil?
          fail
        end
        item[:tags] = item[:tags].split if item.include?(:tags)
        item
      end
    end
  end
end
