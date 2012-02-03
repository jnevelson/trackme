class Event < ActiveRecord::Base

  belongs_to :owner, :class_name => "User"
  has_many :followers, :through => :user_events, :source => :user
  has_many :user_events

  before_validation :set_start_time

  validates_presence_of :owner, :start_time, :end_time
  validate :time_continuity

  def add_follower(user)
    followers << user
  end

  def self.current_events
    now = Time.now
    Event.where("start_time < ? AND end_time > ?", now, now)
  end

  private

  def set_start_time
    self.start_time = Time.now if start_time.nil?
  end

  def time_continuity
    raise "Start time must be before end time!" if end_time < start_time
  end

end
