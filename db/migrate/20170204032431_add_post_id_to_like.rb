class AddPostIdToLike < ActiveRecord::Migration[5.0]
  def change
    add_column :likes, :post_id, :reference, foreign_key: true
  end
end
