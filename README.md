[![Version](https://img.shields.io/gem/v/tottori-opendata-catalog.svg)](https://rubygems.org/gems/tottori-opendata-catalog)

## TottoriOpenDataCatalog

This gem provides an API and a CLI of Open Data Catalog of Tottori Prefecture http://db.pref.tottori.jp/opendataResearch.nsf to generate a machine-readable catalog.

### Installation

    $ gem install tottori-opendata-catalog

### Synopsis

#### API

``` ruby
require 'tottori-opendata-catalog'
# TottoriOpenDataCatalog.get returns a nested ruby's object.
puts TottoriOpenDataCatalog.get
```

``` ruby
require 'tottori-opendata-catalog'
# without caching which uses a local storage (/tmp).
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

### Development

#### Testing

```sh
$ bundle exec rake spec
```
#### Updating example/example.csv

```
$ bundle exec ruby bin/tottori-opendata-catalog csv > example/example.csv
```
