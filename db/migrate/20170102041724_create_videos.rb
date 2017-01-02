class CreateVideos < ActiveRecord::Migration[5.0]
  def change
    create_table :videos do |t|
      t.string :title
      t.string :preview
      t.text :description
      t.string :starring
      t.float :price

      t.timestamps
    end
  end
end
