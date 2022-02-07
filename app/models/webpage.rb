class Webpage < ApplicationRecord
  has_many :sections

  validates :url, presence: true
  validates :url, format: { with: URI.regexp }, if: -> { url.present? }

  after_commit :queue_for_scrapping

  def queue_for_scrapping
    Scrapper.perform_async(self.id)
  end

end
