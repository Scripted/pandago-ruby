require "pandago/errors"

module PandaGo
  module ContentTypes
    TYPES = {
      "markdown" => "text/markdown; charset=UTF-8",
      "html" => "text/html; charset=utf-8",
      "docx" => "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
    }

    def self.[](name)
      TYPES.fetch(name.to_s) { |name| raise ContentTypeNotSupportedError, name }
    end
  end
end
