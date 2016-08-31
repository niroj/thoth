class WebpageSerializer < ActiveModel::Serializer
  attributes :id, :url
  has_many :sections
end
