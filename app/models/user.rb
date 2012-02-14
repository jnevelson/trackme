class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable, :recoverable,
    :rememberable, :trackable, :validatable, :token_authenticatable

  attr_accessible :first_name, :last_name, :email, :password, :password_confirmation, :remember_me

  validates_presence_of :first_name, :last_name, :email

  has_many :locations
  # has_many :friends, :through => :friendships
  # has_many :friendships#, :conditions => proc { ["user_id = ? or friend_id = ?", self.id, self.id] }
  # has_many :inverse_friends, :through => :inverse_friendships, :source => :user
  # has_many :inverse_friendships, :foreign_key => "friend_id", :class_name => "Friendship"
  has_many :owned_events, :foreign_key => "owner_id", :class_name => "Event"
  has_many :followed_events,
      :through => :user_events,
      :source => :event,
      :conditions => proc { ["user_id = ?", self.id] }
  has_many :user_events

  before_create :ensure_authentication_token

  def friends
    # EVIL EVIL EVIL... but I don't know how else to do it for the time being.
    # friend relations are commented out at the top, as well as "inverse_friend" relations
    friendships1 = Friendship.where("user_id = ?", self.id).map(&:friend)
    friendships2 = Friendship.where("friend_id = ?", self.id).map(&:user)
    friendships1 + friendships2
  end

  def add_location(params = {})
    Location.create! :user => self, :longitude => params[:longitude], :latitude => params[:latitude]
  end

  def add_friend(user)
    Friendship.create! :user => self, :friend => user
  end

  def create_event(params = {})
    start_time = params[:start_time] ? params[:start_time] : Time.now
    Event.create! :owner => self, :start_time => start_time, :end_time => params[:end_time]
  end

end
