require "spec_helper"

describe PandaGo do
  it "has a version number" do
    expect(PandaGo::VERSION).not_to be nil
  end

  describe ".convert" do
    let(:source) { StringIO.new("<h1>Hello, World!</h1><p>This is a paragraph</p>") }

    subject { described_class.convert(source, from: :html, to: :markdown) }

    it "takes and IO object and returns an IO object with the result" do
      expect(subject.read).to eq "Hello, World!\n=============\n\nThis is a paragraph\n"
    end

    context "when PandaGo url has not been configured" do
      around do |example|
        old_config = PandaGo.configuration
        PandaGo.instance_variable_set(:@configuration, PandaGo::Configuration.new)
        example.run
        PandaGo.instance_variable_set(:@configuration, old_config)
      end

      it "should raise a UrlNotSetError" do
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
