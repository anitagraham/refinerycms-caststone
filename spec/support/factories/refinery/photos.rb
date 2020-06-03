
FactoryBot.define do
  factory :photo, class: Refinery::Caststone::Photo do
    sequence(:name) { |n| "refinery#{n}" }
  end
end

