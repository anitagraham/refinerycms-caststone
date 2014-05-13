
FactoryGirl.define do
  factory :display, :class => Refinery::Caststone::Display do
    sequence(:name) { |n| "refinery#{n}" }
  end
end

