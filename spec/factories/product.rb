FactoryGirl.define do
  factory :product, :class => Refinery::Caststone::Component do
    sequence(:name) { |n| "Series #{n}" }
  end
end