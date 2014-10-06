class FollowingsMustBeUnique < ActiveRecord::Migration
  def change
    add_index :followings, [:follower_id, :following_id], :unique => true
  end
end
