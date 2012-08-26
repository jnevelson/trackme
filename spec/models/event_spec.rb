require 'spec_helper'

describe Event do
  
  it "should allow for owners" do
    user = FactoryGirl.build(:user1)
    event = user.create_event :start_time => Time.now + 2.hours, :end_time => Time.now + 4.hours
    user.owned_events.first.should == event
  end

  it "should allow for followers" do
    user1 = FactoryGirl.build(:user1)
    user2 = FactoryGirl.build(:user2)
    user3 = FactoryGirl.build(:user3)
    event = FactoryGirl.build(:event1, :owner => user1)
    event.add_follower(user2)
    event.add_follower(user3)

    event.owner.should == user1
    event.followers.size.should == 2
    event.followers.should == [user2, user3]
  end

  it "should default to current time if start_time is nil" do
    owner = FactoryGirl.build(:user1)
    event = Event.create! :end_time => Time.now + 4.hours, :owner => owner

    event.start_time.should_not be_nil
  end

  it "should not allow for end_time to be before start_time" do
    owner = FactoryGirl.build(:user1)
    expect { Event.create! :owner => owner, :start_time => Time.now + 2.hours, :end_time => Time.now }.should raise_error
  end

  it "should return events currently taking place" do
    owner = FactoryGirl.build(:user1)
    current = Event.create! :owner => owner, :start_time => Time.now - 1.hour, :end_time => Time.now + 1.hours
    not_current = Event.create! :owner => owner, :start_time => Time.now + 1.hour, :end_time => Time.now + 2.hours

    Event.current_events.should == [current]
  end

  it "should return current locations" do
    user1 = FactoryGirl.build(:user1)
    user2 = FactoryGirl.build(:user2)
    event = FactoryGirl.build(:event1, :owner => user1, :followers => [user2])
    user1.add_location :longitude => 23.345, :latitude => 54.5676
    user1.add_location :longitude => 23.456, :latitude => 54.6547

    user2.followed_events.size.should == 1
    user2.followed_events.first.locations.size.should == 2
  end

end
