
FactoryGirl.define do
  factory :product, :class => Refinery::Caststone::Product do
    sequence(:name) { |n| "refinery#{n}" }
  end
end

