FactoryGirl.define do

  factory :user1, :class => "User" do
    first_name 'user1'
    last_name 'user1last'
    email 'user1@email.com'
    password 'user1'
  end

  factory :user2, :class => "User" do
    first_name 'first'
    last_name 'last'
    email 'email@email.com'
    password 'blah'
  end

  factory :user3, :class => "User" do
    first_name 'test'
    last_name 'test'
    email 'email@test.com'
    password 'password'
  end

  factory :friend, :class => "User" do
    first_name 'my'
    last_name 'friend'
    email 'friend@email.com'
    password 'friend'
  end

  factory :friendship do
  end

  factory :event1, :class => "Event" do
    description 'test description'
    start_time Time.now
    end_time Time.now + 4.hours
  end

end