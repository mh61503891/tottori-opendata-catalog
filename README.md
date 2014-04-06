[![Version](https://img.shields.io/gem/v/tottori-opendata-catalog.svg)](https://rubygems.org/gems/tottori-opendata-catalog)

## TottoriOpenDataCatalog

This gem provides an API and a CLI of Open Data Catalog of Tottori Prefecture http://db.pref.tottori.jp/opendataResearch.nsf to generate a machine-readable catalog.

### Installation

    $ gem install cardamon

### Synopsis

#### API

``` ruby
require 'tottori-opendata-catalog'
# TottoriOpenDataCatalog.get returns a nested ruby's object.
puts TottoriOpenDataCatalog.get
```

``` ruby
require 'tottori-opendata-catalog'
# without caching using a local strage (/tmp).
puts TottoriOpenDataCatalog.get(cache:false)
```

#### CLI

``` sh
$ tottori-opendata-catalog csv > catalog.csv
```

``` sh
$ tottori-opendata-catalog json > catalog.json
```

``` sh
$ tottori-opendata-catalog json --no-cache > catalog.json
```