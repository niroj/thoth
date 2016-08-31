require "rails_helper"
require "#{Rails.root}/lib/web_scrapper.rb"

RSpec.describe "Web Scrapper" do
  describe "#valid_url?" do
    it "should return true for valid url" do
      expect(WebSrapper.new.valid_url?).to be false
      expect(WebSrapper.new(url: "example").valid_url?).to be false
      expect(WebSrapper.new(url: "http://example.com").valid_url?).to be true
    end
  end
  describe "#valid_tag_types?" do
    it "should return true for valid tag types" do
      expect(WebSrapper.new.valid_tag_types?).to be false
      expect(WebSrapper.new(tag_types: "example").valid_tag_types?).to be false
      expect(WebSrapper.new(tag_types: []).valid_tag_types?).to be false
      expect(WebSrapper.new(tag_types: [:h1]).valid_tag_types?).to be true
    end
  end
  describe "#valid?" do
    it "should return true for valid tag types" do
      expect(WebSrapper.new.valid?).to be false
      expect(WebSrapper.new(tag_types: "example").valid?).to be false
      expect(WebSrapper.new(tag_types: []).valid?).to be false
      expect(WebSrapper.new(url: "example").valid?).to be false
      expect(WebSrapper.new(url: "http://example.com").valid?).to be false
      expect(WebSrapper.new(tag_types: [:h1]).valid?).to be false
      expect(WebSrapper.new(url: "http://example.com", tag_types: [:h1]).valid?).to be true
    end
  end
  describe "#errors" do
    it "should return proper errors" do
      expect(WebSrapper.new(url: "http://example.com", tag_types: [:h1]).errors).to be {}
      expect(WebSrapper.new(tag_types: "example").errors).to eql({url: 'is invalid', tag_types: 'is invalid'})
      expect(WebSrapper.new(tag_types: [:h1]).errors).to eql({url: 'is invalid'})
      expect(WebSrapper.new(url: "example").errors).to eql({url: 'is invalid', tag_types: 'is invalid'})
      expect(WebSrapper.new(url: "http://example.com").errors).to eql({tag_types: 'is invalid'})
    end
  end

  describe "#fetch_page" do
    it "should return false for invalid url" do
      expect(WebSrapper.new.fetch_page).to be false
    end

    it "should call mechanize instance with given url" do
      VCR.use_cassette('webpage_get_test') do
        expect_any_instance_of(Mechanize).to receive(:get).with(TEST_URL).and_call_original

        expect(WebSrapper.new(url: TEST_URL, tag_types: [:h1]).fetch_page.class).to eql(Mechanize::Page)
      end
    end
  end

  describe "#fetch_page_and_scrap" do
    it "should return false for invalid url" do
      expect(WebSrapper.new.fetch_page_and_scrap).to be false
    end

    it "should return array of required tags" do
      VCR.use_cassette('webpage_get_test') do
        sections = WebSrapper.new(url: TEST_URL, tag_types: [:h1]).fetch_page_and_scrap
        expect(sections.collect{|st| st[:section_type]}.uniq).to eql([:h1])

        # there are 13 h1 sections in test fixture
        expect(sections.count).to eql(13)
      end
    end
  end
end
