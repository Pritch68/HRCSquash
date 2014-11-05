# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event do
    title "MyString"
    startdate "2014-11-05 02:03:51"
    enddate "2014-11-05 02:03:51"
    body "MyText"
  end
end
