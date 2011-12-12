class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.string :number
      t.string :signup_url
      t.string :source
      t.text   :description
      t.string :start_date
      t.string :start_time
      t.string :end_date
      t.string :end_time

      t.timestamps
    end
  end
end
