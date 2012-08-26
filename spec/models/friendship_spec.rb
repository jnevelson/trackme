require 'spec_helper'

describe Friendship do

  it "should create friends" do
    user = FactoryGirl.build(:user1)
    friend = FactoryGirl.build(:friend)

    user.add_friend(friend)
    user.friends.first.should == friend
  end
  
  it "should friend people bidirectionally" do
    user1 = FactoryGirl.build(:user1)
    user2 = FactoryGirl.build(:user2)
    user1.add_friend(user2)

    user1.friends.should == [user2]
    user2.friends.should == [user1]
  end

end
