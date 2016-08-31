class Webpage < ApplicationRecord
  has_many :sections

  validates :url, presence: true
  validates :url, format: { with: URI.regexp }, if: 'url.present?'
end
