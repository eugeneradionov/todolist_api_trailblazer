FactoryBot.define do
  factory :project do
    name { FFaker::Internet.user_name }
    user
  end
end
