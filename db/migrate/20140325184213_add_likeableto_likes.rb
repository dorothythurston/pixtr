class AddLikeabletoLikes < ActiveRecord::Migration
  def change
    rename_column :likes, :image_id, :likable_id
    add_column :likes, :likable_type, :string

    remove_index :likes, :likable_id
    add_index :likes, [:likable_type]

    update "Update likes SET likable_type = 'Image'"
  end
end
