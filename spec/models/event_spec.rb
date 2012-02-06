require 'spec_helper'

describe Event do
  
  it "should allow for owners" do
    user = Factory(:user)
    event = user.create_event :start_time => Time.now + 2.hours, :end_time => Time.now + 4.hours
    user.owned_events.first.should == event
  end

  it "should allow for followers" do
    user = Factory(:user)
    user1 = Factory(:user1)
    friend = Factory(:friend)
    event = Factory(:event1, :owner => user)
    event.add_follower(user1)
    event.add_follower(friend)

    event.owner.should == user
    event.followers.size.should == 2
    event.followers.should == [user1, friend]
  end

  it "should default to current time if start_time is nil" do
    owner = Factory(:user)
    event = Event.create! :end_time => Time.now + 4.hours, :owner => owner

    event.start_time.should_not be_nil
  end

  it "should not allow for end_time to be before start_time" do
    owner = Factory(:user)
    expect { Event.create! :owner => owner, :start_time => Time.now + 2.hours, :end_time => Time.now }.should raise_error
  end

  it "should return events currently taking place" do
    owner = Factory(:user)
    current = Event.create! :owner => owner, :start_time => Time.now - 1.hour, :end_time => Time.now + 1.hours
    not_current = Event.create! :owner => owner, :start_time => Time.now + 1.hour, :end_time => Time.now + 2.hours

    Event.current_events.should == [current]
  end

end
