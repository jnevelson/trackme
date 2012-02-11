require 'spec_helper'

describe User do

  attributes = { :first_name => "test", :last_name => "test", :email => "test@test.com", :password => "test" }

  it "should validate presence of fields" do
    expect { User.create! }.to raise_exception
  end

  it "should create a new user" do
    @user = User.create!(attributes)
    @user[:first_name].should equal(attributes[:first_name])
  end

  it "should generate an api key when the user is created" do
    @user = User.create!(attributes)
    @user.authentication_token.should_not equal(nil)
  end

  it "should not regenerate API keys on save" do
    @user = User.create!(attributes)
    @api = @user.authentication_token

    @user.save!

    @api.should == @user.authentication_token
  end

  it "should create new locations belonging to current user" do
    @user = Factory.build(:user1)
    params = { :latitude => 37.75412, :longitude => -122.45121 }
    @user.add_location(params)
    @user.locations.first.longitude.should == params[:longitude].to_s
  end

  it "should create friends" do
    @user = Factory(:user1)
    @friend = Factory(:friend)

    @user.add_friend(@friend)
    @user.friends.first.should == @friend
  end

  it "should return current followed events" do
    user1 = Factory(:user1)
    user2 = Factory(:user2)
    user3 = Factory(:user3)
    event1 = Factory(:event1, :owner => user1, :followers => [user2, user3])
    event2 = Factory(:event1, :owner => user1, :followers => [user3])

    user2.current_followed_events.should == [event1]
    user3.current_followed_events.should == [event1, event2]
  end

end
