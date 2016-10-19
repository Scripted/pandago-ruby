require "spec_helper"

describe PandaGo::Converter do

  describe "#convert" do
    let(:source_markdown) { SPEC_ROOT.join("fixtures/source.md").open }
    let(:source_html) { SPEC_ROOT.join("fixtures/source.html").open }
    let(:source_docx) { SPEC_ROOT.join("fixtures/source.docx").open }

    let(:expect_markdown) { SPEC_ROOT.join("fixtures/expect.md").open }
    let(:expect_html) { SPEC_ROOT.join("fixtures/expect.html").open }

    context "when converting from html" do
      it "should convert to html" do
        subject = described_class.new(source_html, :html, :html, PandaGo.url)
        expect(subject.convert.read).to eq expect_html.read
      end

      it "should convert to markdown" do
        subject = described_class.new(source_html, :html, :markdown, PandaGo.url)
        expect(subject.convert.read).to eq expect_markdown.read
      end

      it "should convert to docx" # TODO: figure out how to implement this
    end

    context "when converting from markdown" do
      it "should convert to html" do
        subject = described_class.new(source_markdown, :markdown, :html, PandaGo.url)
        expect(subject.convert.read).to eq expect_html.read
      end

      it "should convert to markdown" do
        subject = described_class.new(source_markdown, :markdown, :markdown, PandaGo.url)
        expect(subject.convert.read).to eq expect_markdown.read
      end

      it "should convert to docx" # TODO: figure out how to implement this
    end

    context "when converting from docx" do
      it "should convert to html" do
        subject = described_class.new(source_docx, :docx, :html, PandaGo.url)
        expect(subject.convert.read).to eq expect_html.read
      end

      it "should convert to markdown" do
        subject = described_class.new(source_docx, :docx, :markdown, PandaGo.url)
        expect(subject.convert.read).to eq expect_markdown.read
      end

      it "should convert to docx" # TODO: figure out how to implement this
    end
  end
end
