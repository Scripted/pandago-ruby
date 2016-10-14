require "pandago/content_types"

module Pandago
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

      body = ""

      body << "--#{ BOUNDARY }\r\n"
      body << "Content-Disposition: form-data; name=\"from\"\r\n\r\n"
      body << "#{ read_format }\r\n"

      body << "--#{ BOUNDARY }\r\n"
      body << "Content-Disposition: form-data; name=\"to\"\r\n\r\n"
      body << "#{ write_format }\r\n"

      body << "--#{ BOUNDARY }\r\n"
      body << "Content-Disposition: form-data; name=\"payload\"; filename=\"payload\"\r\n"
      body << "Content-Type: #{ ContentTypes[read_format] }\r\n\r\n"
      body << source_io.read
      body << "\r\n"

      body << "--#{ BOUNDARY }--\r\n"
      body
    end
  end
end
