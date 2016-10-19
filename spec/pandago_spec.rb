require "spec_helper"

describe PandaGo do
  it "has a version number" do
    expect(PandaGo::VERSION).not_to be nil
  end

  describe ".url" do
    before { @old_url = PandaGo.class_variable_get(:@@url) }
    after { PandaGo.class_variable_set(:@@url, @old_url) }

    it "should be able to get and set url" do
      described_class.url = "https://example.com"
      expect(described_class.url).to eq URI("https://example.com")
    end
  end

  describe ".convert" do
    let(:source) { StringIO.new("<h1>Hello, World!</h1><p>This is a paragraph</p>") }

    subject { described_class.convert(source, from: :html, to: :markdown) }

    it "takes and IO object and returns an IO object with the result" do
      expect(subject.read).to eq "Hello, World!\n=============\n\nThis is a paragraph\n"
    end

    context "when PandaGo.url has not been set" do
      before { @old_url = PandaGo.class_variable_get(:@@url) }
      after { PandaGo.class_variable_set(:@@url, @old_url) }

      it "should raise a UrlNotSetError" do
        PandaGo.class_variable_set(:@@url, nil)
        expect { subject }.to raise_error PandaGo::UrlNotSetError
      end
    end

    context "when the server returns an error" do
      before { stub_request(:post, "localhost:8080/convert").to_return(status: [500, "Internal Server Error"]) }

      it "should raise a RequestError" do
        expect { subject }.to raise_error PandaGo::RequestError, /500 Internal Server Error/
      end
    end
  end
end
