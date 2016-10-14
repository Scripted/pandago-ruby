module Pandago
  module ContentTypes
    TYPES = {
      "markdown" => "text/markdown; charset=UTF-8",
      "html" => "text/html; charset=utf-8",
      "docx" => "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
    }

    def self.[](name)
      TYPES.fetch(name.to_s) { |name| raise "Content-Type not supported for: #{ name }" }
    end
  end
end
