require 'open-uri'
require 'digest/sha1'
require 'tmpdir'

module TottoriOpenDataCatalog

  module Net

    class << self

      def get(url, cache:true)
        return open(url, &:read) unless cache
        path = File.join(Dir.tmpdir, Digest::SHA1.hexdigest(url))
        @memo ||= {}
        if @memo.include?(path)
          @memo[path]
        else
          if File.exists?(path)
            @memo[path] ||= open(path, &:read)
          else
            content = open(url, &:read)
            open(path, 'w'){ |io| io.write(content) }
            @memo[path] ||= content
          end
        end
      end

    end

  end

end
