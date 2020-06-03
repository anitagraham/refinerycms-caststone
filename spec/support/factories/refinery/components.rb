FactoryBot.define do
  factory :component, class: Refinery::Caststone::Component do
    sequence(:name) { |n| "refinery#{n}" }
  end
end

