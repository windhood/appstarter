class AddAvatarToUses < ActiveRecord::Migration
  def change
    add_column :uses, :avatar, :string
  end
end
