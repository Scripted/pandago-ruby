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

    describe "with actual files" do
      let(:source_markdown) { SPEC_ROOT.join("fixtures/source.md").open }
      let(:source_html) { SPEC_ROOT.join("fixtures/source.html").open }
      let(:source_docx) { SPEC_ROOT.join("fixtures/source.docx").open }

      let(:expect_markdown) { SPEC_ROOT.join("fixtures/expect.md").open }
      let(:expect_html) { SPEC_ROOT.join("fixtures/expect.html").open }
      let(:expect_docx) { SPEC_ROOT.join("fixtures/expect.docx").open }

      context "when converting from html" do
        it "should convert to html" do
          converted = described_class.convert(source_html, from: :html, to: :html)
          expect(converted.read).to eq expect_html.read
        end

        it "should convert to markdown" do
          converted = described_class.convert(source_html, from: :html, to: :markdown)
          expect(converted.read).to eq expect_markdown.read
        end

        it "should convert to docx" # TODO: figure out how to implement this
      end

      context "when converting from markdown" do
        it "should convert to html" do
          converted = described_class.convert(source_markdown, from: :markdown, to: :html)
          expect(converted.read).to eq expect_html.read
        end

        it "should convert to markdown" do
          converted = described_class.convert(source_markdown, from: :markdown, to: :markdown)
          expect(converted.read).to eq expect_markdown.read
        end

        it "should convert to docx" # TODO: figure out how to implement this
      end

      context "when converting from docx" do
        it "should convert to html" do
          converted = described_class.convert(source_docx, from: :docx, to: :html)
          expect(converted.read).to eq expect_html.read
        end

        it "should convert to markdown" do
          converted = described_class.convert(source_docx, from: :docx, to: :markdown)
          expect(converted.read).to eq expect_markdown.read
        end

        it "should convert to docx" # TODO: figure out how to implement this
      end
    end
  end
end
