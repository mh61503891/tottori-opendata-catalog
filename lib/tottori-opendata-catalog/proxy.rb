
module TottoriOpenDataCatalog

  module Proxy

    INDEX_URL = 'http://db.pref.tottori.jp/opendataResearch.nsf/index.html'

    class << self

      def get(cache:true)
        index = Parser.parse_index(Net.get(INDEX_URL, cache:cache))
        index[:categories].each do |category|
          category[:link] = File.join(File.dirname(INDEX_URL), category[:link])
          category[:resources] ||= []
          Parser.parse_list(Net.get(category[:link], cache:cache)).each do |resource|
            resource[:link] = File.join(File.dirname(INDEX_URL), resource[:link])
            resource.merge!(Parser.parse_record(Net.get(resource[:link], cache:cache)))
            category[:resources] << resource
          end
        end
        return index
      end

    end

  end

end
