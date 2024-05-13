class CreateWatches < ActiveRecord::Migration[7.1]
  def change
    create_table :watches do |t|
      t.string :name
      t.text :description
      t.string :category
      t.decimal :price
      t.string :image_url

      t.timestamps
    end
  end
end
