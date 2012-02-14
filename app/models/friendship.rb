class Friendship < ActiveRecord::Base

  validate :friend_self

  belongs_to :friend, :foreign_key => "friend_id", :class_name => "User"
  belongs_to :user, :foreign_key => "user_id", :class_name => "User"

  private

  def friend_self
    raise "You cannot friend yourself!" if user == friend
  end

end
