require "rails_helper"
require "#{Rails.root}/lib/web_scrapper.rb"

RSpec.describe "Scrapper Worker" do
  it "should call scrapper class with proper url" do
    expect_any_instance_of(Webpage).to receive(:queue_for_scrapping)
    expect_any_instance_of(WebSrapper).to receive(:initialize).with({url: TEST_URL, tag_types: Section::VALID_TYPES})
    webpage = FactoryGirl.create(:webpage, url: TEST_URL)
    Scrapper.new.perform(webpage.id)
  end

  it "should only store the give tags" do
    VCR.use_cassette('webpage_store_given_tags') do
      expect_any_instance_of(Webpage).to receive(:queue_for_scrapping)
      webpage = FactoryGirl.create(:webpage, url: TEST_URL)
      Scrapper.new.perform(webpage.id)
      expect(Section.all.collect(&:section_type).uniq.compact.sort).to eql(Section::VALID_TYPES.sort)
    end
  end

  it "should only store correct contents" do
    # if every section is correct and there total number is correct
    # then there should not be wrong records

    VCR.use_cassette('webpage_store_correct_contents') do
      expect_any_instance_of(Webpage).to receive(:queue_for_scrapping)
      webpage = FactoryGirl.create(:webpage, url: TEST_URL)
      Scrapper.new.perform(webpage.id)

      page = Mechanize.new.get(TEST_URL)
      Section::VALID_TYPES.each do |valid_type|
        page.search(valid_type).each do |tag|

          #check every section for contents
          expect(webpage.sections.where(section_type: valid_type, content: tag.content, webpage_id: webpage.id)).to be_present
        end

        #check total number of records for each valid types.
        expect(page.search(valid_type).count).to eql(Section.where(section_type: valid_type).count)
      end
    end
  end
end
