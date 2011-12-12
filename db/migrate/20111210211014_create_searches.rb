class CreateSearches < ActiveRecord::Migration
  def change
    create_table :searches do |t|
      t.date :start_date
      t.date :end_date
      t.string :keyword
      t.boolean :match_all

      t.timestamps
    end
  end
end
