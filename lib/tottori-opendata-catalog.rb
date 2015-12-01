require 'tottori-opendata-catalog/version'
require 'tottori-opendata-catalog/parser'
require 'tottori-opendata-catalog/net'
require 'tottori-opendata-catalog/proxy'
require 'tottori-opendata-catalog/command'

module TottoriOpenDataCatalog
  def self.get(cache:true)
    TottoriOpenDataCatalog::Proxy.get(cache: cache)
  end
end
