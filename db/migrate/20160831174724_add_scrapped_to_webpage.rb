class AddScrappedToWebpage < ActiveRecord::Migration[5.0]
  def change
    add_column :webpages, :scrapped, :boolean, default: false
  end
end
