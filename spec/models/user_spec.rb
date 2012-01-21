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
    @user.api_key.should_not equal(nil)
  end

  # TODO
  # test failing due to rounding inaccuracy. we need to figure out how to store accurate floats
  # check out https://github.com/andre/geokit-rails
  it "should create new locations belonging to current user" do
    @user = Factory.build(:user)
    params = { :latitude => 37.75412, :longitude => -122.45121 }
    @user.post_location(params)
    @user.locations.first.longitude.should == params[:longitude]
  end

  it "should create friends" do
    @user = Factory(:user)
    @friend = Factory(:friend)

    @user.add_friend(@friend)
    @user.friends.first.should == @friend
  end

end
