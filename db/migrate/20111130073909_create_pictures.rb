class CreatePictures < ActiveRecord::Migration
  create_table :pictures do |t|
    t.string :title
    t.text :description
    t.string :file

    t.timestamps
  end  
end
