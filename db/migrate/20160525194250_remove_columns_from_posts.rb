class RemoveColumnsFromPosts < ActiveRecord::Migration
  def change
    remove_column :posts, :title
    remove_column :posts, :description
  end
end
