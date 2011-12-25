class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.string :title
      t.text :description
      t.string :file
      t.integer :user_id
      t.timestamps
    end  
  end
end
