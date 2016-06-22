class AddReferToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :referemail, :string
  end
end
