class CreateSections < ActiveRecord::Migration[5.0]
  def change
    create_table :sections do |t|
      t.string :section_type
      t.references :webpage, foreign_key: true
      t.text :content

      t.timestamps
    end
  end
end
