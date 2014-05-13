
FactoryGirl.define do
  factory :tag, :class => Refinery::Caststone::Tag do
    sequence(:name) { |n| "refinery#{n}" }
  end
end

