require "spec_helper"

describe Pandago do
  it "has a version number" do
    expect(Pandago::VERSION).not_to be nil
  end

  describe ".url" do
    before { @old_url = Pandago.class_variable_get(:@@url) }
    after { Pandago.class_variable_set(:@@url, @old_url) }

    it "should be able to get and set url" do
      described_class.url = "https://example.com"
      expect(described_class.url).to eq URI("https://example.com")
    end
  end

  describe ".convert" do
    let(:source) { StringIO.new("<h1>Hello, World!</h1><p>This is a paragraph</p>") }

    it "takes and IO object and returns an IO object with the result" do
      converted = described_class.convert(source, from: :html, to: :markdown)
      expect(converted.read).to eq "Hello, World!\n=============\n\nThis is a paragraph\n"
    end
  end
end
