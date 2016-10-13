require "spec_helper"

describe Pandago do
  it "has a version number" do
    expect(Pandago::VERSION).not_to be nil
  end

  describe ".url" do
    before { @old_url = Pandago.class_variable_get(:@@url) }
    after { Pandago.class_variable_set(:@@url, @old_url) }

    it "should be able to get and set url" do
      Pandago.url = "https://example.com"
      expect(Pandago.url).to eq URI("https://example.com")
    end
  end


end
