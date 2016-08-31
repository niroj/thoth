class Section < ApplicationRecord
  belongs_to :webpage

  VALID_TYPES = ['a', 'h1', 'h2', 'h3']

  validates_presence_of :section_type, :webpage
end
