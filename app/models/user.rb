class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable, :recoverable,
    :rememberable, :trackable, :validatable, :token_authenticatable

  attr_accessible :first_name, :last_name, :email, :password, :password_confirmation, :remember_me

  validates_presence_of :first_name, :last_name, :email

  has_many :locations
  has_many :friends, :through => :friendships, :class_name => "User"
  has_many :friendships, :foreign_key => "user_id"
  has_many :owned_events, :foreign_key => "owner_id", :class_name => "Event"
  has_many :followed_events,
      :through => :user_events,
      :source => :event,
      :conditions => proc { ["user_id = ?", self.id] }
  has_many :user_events

  before_create :ensure_authentication_token

  def add_location(params = {})
    Location.create! :user => self, :longitude => params[:longitude], :latitude => params[:latitude]
  end

  def add_friend(user)
    Friendship.create! :user => self, :friend => user
  end

  def create_event(params = {})
    raise "Must include end_time!" unless params[:end_time]
    start_time = params[:start_time] ? params[:start_time] : Time.now
    Event.create! :owner => self, :start_time => start_time, :end_time => params[:end_time]
  end

end
