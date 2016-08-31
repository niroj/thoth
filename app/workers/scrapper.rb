require "#{Rails.root}/lib/web_scrapper.rb"

class Scrapper
  include Sidekiq::Worker
  def perform(webpage_id)
    ActiveRecord::Base.connection_pool.with_connection do
      webpage = Webpage.find_by(id: webpage_id)
      if webpage && !webpage.scrapped
        # delete all to avoid duplicates
        webpage.sections.delete_all

        web_scrapper = WebSrapper.new(url: webpage.url, tag_types: Section::VALID_TYPES)
        if all_sections = web_scrapper.fetch_page_and_scrap
          all_sections.each do |section|
            Section.create(section.merge(webpage: webpage))
          end
          webpage.update_column(:scrapped, true)
        end
      end
    end
  end
end