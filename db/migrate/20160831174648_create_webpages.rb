class CreateWebpages < ActiveRecord::Migration[5.0]
  def change
    create_table :webpages do |t|
      t.string :url

      t.timestamps
    end
  end
end
