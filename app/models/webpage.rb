class Webpage < ApplicationRecord
  has_many :sections

  validates :url, presence: true
  validates :url, format: { with: URI.regexp }, if: 'url.present?'

  after_commit :fetch_page_and_save

  def fetch_page_and_save
    page = Mechanize.new.get(url)

    Section::VALID_TYPES.each do |valid_type|
      page.search(valid_type).each do |tag|
        self.sections.create(section_type: valid_type, content: tag.text)
      end
    end
  end
end
