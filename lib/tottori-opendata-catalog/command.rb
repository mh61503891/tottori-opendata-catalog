require 'tottori-opendata-catalog/proxy'

module TottoriOpenDataCatalog

  module Command

    class << self

      def to_json(cache:true)
        require 'json'
        JSON.pretty_generate(TottoriOpenDataCatalog::Proxy.get(cache:cache))
      end

      def to_csv(cache:true)
        require 'csv'
        CSV(csv = '') do |line|
          data = TottoriOpenDataCatalog::Proxy.get(cache:cache)
          line << %w{
            category_name
            resource_name formats department division tags
            redistribution_allowed commercial_use_allowed
            provider tel description comment
            year month day
            repeat_rule_frequency repeat_rule_interval repeat_rule_description
          }
          data[:categories].each do |category|
            category[:resources].each do |resource|
              row = []
              row << category[:name]
              row << resource[:name]
              row << resource[:formats].join(' ')
              row << resource[:department]
              row << resource[:division]
              row << resource[:tags].join(' ')
              row << resource[:redistribution_allowed]
              row << resource[:commercial_use_allowed]
              row << resource[:provider]
              row << resource[:tel]
              row << resource[:description]
              row << resource[:comment]
              row << resource[:year]
              row << resource[:month]
              row << resource[:day]
              row << resource[:repeat_rule][:frequency]
              row << resource[:repeat_rule][:interval]
              row << resource[:repeat_rule][:description]
              line << row
            end
          end
        end
        return csv
      end
    end

  end

end
