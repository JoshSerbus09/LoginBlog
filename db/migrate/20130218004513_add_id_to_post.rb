class AddIdToPost < ActiveRecord::Migration
  def change
    add_column :posts, :uid, :int
  end
end
