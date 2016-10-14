require "pandago/version"
require "pandago/content_types"

module Pandago
  BOUNDARY = "__X_PANDAGO_BOUNDARY_QYcwwbmfzj3rfKcMk7AWNw__"
  @@url = nil

  class << self
    def url
      @@url
    end

    def url=(url)
      @@url = URI(url)
      self.url
    end

    def convert(file, from:, to:)
      http = Net::HTTP.new(url.host, url.port)
      request = Net::HTTP::Post.new("/convert", header)
      request.body = body(file, from, to)
      response = http.request(request)
      StringIO.new(response.body)
    end

    def header
      { "content-type" => "multipart/form-data; charset=utf-8; boundary=#{ BOUNDARY }" }
    end

    def body(file, from, to)
      file.rewind

      body = ""

      body << "--#{ BOUNDARY }\r\n"
      body << "Content-Disposition: form-data; name=\"from\"\r\n\r\n"
      body << "#{ from }\r\n"

      body << "--#{ BOUNDARY }\r\n"
      body << "Content-Disposition: form-data; name=\"to\"\r\n\r\n"
      body << "#{ to }\r\n"

      body << "--#{ BOUNDARY }\r\n"
      body << "Content-Disposition: form-data; name=\"payload\"; filename=\"heroku-custom-binaries.md\"\r\n"
      body << "Content-Type: #{ ContentTypes[from] }\r\n\r\n"
      body << file.read
      body << "\r\n"

      body << "--#{ BOUNDARY }--\r\n"
      body
    end
  end
end
