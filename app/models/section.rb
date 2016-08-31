class Section < ApplicationRecord
  belongs_to :webpage

  VALID_TYPES = ['a', 'h1', 'h2', 'h3']
end
