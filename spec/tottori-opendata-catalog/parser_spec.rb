require 'spec_helper'

describe TottoriOpenDataCatalog::Parser do
  def index_url
    TottoriOpenDataCatalog::Proxy::INDEX_URL
  end

  def parse_index
    @index ||= TottoriOpenDataCatalog::Parser.parse_index(TottoriOpenDataCatalog::Net.get(index_url))
  end

  def parse_list(path)
    url = File.join(File.dirname(index_url), path)
    @lists ||= {}
    @lists[url] ||= TottoriOpenDataCatalog::Parser.parse_list(TottoriOpenDataCatalog::Net.get(url))
  end

  def parse_record(path)
    url = File.join(File.dirname(index_url), path)
    @records ||= {}
    @records[url] ||= TottoriOpenDataCatalog::Parser.parse_record(TottoriOpenDataCatalog::Net.get(url))
  end

  describe '#parse_index' do
    it 'does not raise errors.' do
      expect do
        parse_index
      end.not_to raise_error
    end

    it 'returns valid data.' do
      index = parse_index
      expect(index[:name].blank?).to be false
      expect(index[:categories].blank?).to be false
      index[:categories].each do |category|
        expect(category[:name].blank?).to be false
        expect(category[:link].blank?).to be false
      end
    end
  end

  describe '#parse_list' do
    it 'does not raise errors.' do
      parse_index[:categories].each do |list|
        expect do
          parse_list(list[:link])
        end.not_to raise_error
      end
    end

    it 'returns valid data.' do
      parse_index[:categories].each do |list|
        parse_list(list[:link]).each do |table|
          expect(table[:name].blank?).to be false
          expect(table[:link].blank?).to be false
        end
      end
    end
  end

  describe '#parse_record' do
    it 'does not raise errors.' do
      parse_index[:categories].each do |list|
        parse_list(list[:link]).each do |record|
          expect do
            parse_record(record[:link])
          end.not_to raise_error
        end
      end
    end

    it 'returns valid data.' do
      # TODO: ;)
    end
  end
end
