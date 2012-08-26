class EventsController < ApplicationController

  before_filter :authenticate_user!

  def create
    if user = User.find_by_authentication_token(params[:auth_token])
      begin
        event = Event.create!({
          :owner => user,
          :start_time => create_time("start"),
          :end_time => create_time("end"),
          :followers => followers
        })
        render :json => { :success => true, :event => event.id }
      rescue => e
        render_json(false, e.message)
      end
    else
      render_json(false, "Invalid auth_token")
    end
  end

  def add_follower
    if user = User.find_by_authentication_token(params[:auth_token])
      begin
        event = Event.find(params[:event])
        followers.each { |f| event.add_follower(f) }
        render :json => { :success => true, :event => event.id }
      rescue => e
        render_json(false, e.message)
      end
    else
      render_json(false, "Invalid auth_token")
    end
  end

  protected

  def followers
    params[:followers] ? params[:followers].split(",").map { |f| User.find(f) } : []
  end

  def create_time(start_end)
    raise "Must be start or end!" unless start_end == "start" || start_end == "end"
    date, time = "#{start_end}_date", "#{start_end}_time"
    return nil unless params[date] || params[time]
    Time.parse("#{params[date]} #{params[time]}")
  end

end