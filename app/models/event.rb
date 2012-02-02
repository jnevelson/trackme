class Event < ActiveRecord::Base

  belongs_to :owner, :class_name => "User"
  has_many :followers, :through => :user_events, :source => :user
  has_many :user_events

  def add_follower(user)
    followers << user
  end

end
