# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :score do
    date "2014-08-23 18:51:29"
    player1_id 1
    player2_id 2
    matchscore 1
    player1_change 1
    player2_change 1
  end
end
