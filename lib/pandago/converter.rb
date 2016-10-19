require "net/http"
require "pandago/content_types"

module PandaGo
  class Converter
    BOUNDARY = "__X_PANDAGO_BOUNDARY_QYcwwbmfzj3rfKcMk7AWNw__"

    attr_reader :source_io, :read_format, :write_format, :url

    def initialize(source_io, read_format, write_format, url)
      @source_io, @read_format, @write_format = source_io, read_format, write_format
      @url = url
    end

    def converted_content
      StringIO.new(response.body)
    end

    def request
      return @request if defined? @request
      @request = Net::HTTP::Post.new("/convert", header)
      @request.body = body
      @request
    end

    def response
      @response ||= Net::HTTP.new(url.host, url.port).request(request)
    end

    def header
      { "content-type" => "multipart/form-data; charset=utf-8; boundary=#{ BOUNDARY }" }
    end

    def body
      source_io.rewind
      <<~BODY
        --#{ BOUNDARY }
        Content-Disposition: form-data; name="from"

        #{ read_format }
        --#{ BOUNDARY }
        Content-Disposition: form-data; name="to"

        #{ write_format }
        --#{ BOUNDARY }
        Content-Disposition: form-data; name="payload"; filename="payload"
        Content-Type: #{ ContentTypes[read_format] }

        #{ source_io.read }

        --#{ BOUNDARY }--
      BODY
    end
  end
end
