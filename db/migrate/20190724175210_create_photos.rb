class CreatePhotos < ActiveRecord::Migration[5.2]
  def change
    create_table :photos do |t|
      t.integer :user_id
      t.text :image_data
      t.string :image_url

      t.timestamps
    end
  end
end
