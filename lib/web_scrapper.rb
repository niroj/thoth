class WebSrapper
  attr_accessor :url, :tag_types

  def initialize(params = {})
    @url = params[:url]
    @tag_types = params[:tag_types]
  end

  def valid?
    valid_url? && valid_tag_types?
  end

  def valid_url?
    @url.present? && @url.respond_to?(:match) && @url.match(URI.regexp).present?
  end

  def valid_tag_types?
    @tag_types.present? && @tag_types.respond_to?(:each)
  end

  def errors
    error_hash = Hash.new
    error_hash.merge!(url: 'is invalid') unless valid_url?
    error_hash.merge!(tag_types: 'is invalid') unless valid_tag_types?
    error_hash
  end

  def fetch_page
    return false unless valid?

    Mechanize.new.get(@url)
  end

  def fetch_page_and_scrap
    page = fetch_page
    return false unless page
    all_sections = []
    @tag_types.each do |valid_type|
      page.search(valid_type).each do |tag|
        all_sections << {section_type: valid_type, content: tag.text}
      end
    end
    all_sections
  end

end