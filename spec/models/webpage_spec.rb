require 'rails_helper'

RSpec.describe Webpage, type: :model do
  it { should validate_presence_of(:url) }

  it "should have valid url" do
    expect(FactoryGirl.build(:webpage, url: "http://example.com")).to be_valid
    expect(FactoryGirl.build(:webpage, url: "example")).to_not be_valid
  end

  describe "#fetch_page_and_save" do
    before(:each) do
      @url = 'http://bootswatch.com/paper'
    end
    it "should call #fetch_page_and_save on create" do
      expect_any_instance_of(Webpage).to receive(:fetch_page_and_save)
      webpage = FactoryGirl.create(:webpage, url: @url)
    end

    it "should get the page from given url" do
      VCR.use_cassette('webpage_get_test') do
        expect_any_instance_of(Mechanize).to receive(:get).with(@url).and_return(Mechanize.new.get(@url))
        webpage = FactoryGirl.create(:webpage, url: @url)
      end
    end

    it "should only store the give tags" do
      VCR.use_cassette('webpage_store_given_tags') do
        webpage = FactoryGirl.create(:webpage, url: @url)
        expect(Section.all.collect(&:section_type).uniq.compact.sort).to eql(Section::VALID_TYPES.sort)
      end
    end

    it "should only store correct contents" do
      # if every section is correct and there total number is correct
      # then there should not be wrong records
      VCR.use_cassette('webpage_store_correct_contents') do
        webpage = FactoryGirl.create(:webpage, url: @url)

        page = Mechanize.new.get(@url)
        Section::VALID_TYPES.each do |valid_type|
          page.search(valid_type).each do |tag|

            #check every section for contents
            expect(Section.where(section_type: valid_type, content: tag.content, webpage_id: webpage.id)).to be_present
          end

          #check total number of records for each valid types.
          expect(page.search(valid_type).count).to eql(Section.where(section_type: valid_type).count)
        end
      end
    end

  end

end
