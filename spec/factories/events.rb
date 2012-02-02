FactoryGirl.define do
  
  factory :event1, :class => "Event" do
    description 'test description'
    start_time Time.now
    end_time Time.now + 4.hours
  end

end
