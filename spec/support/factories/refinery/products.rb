
FactoryBot.define do
  factory :product, class: Refinery::Caststone::Product do
    sequence(:name) { |n| "Series #{n}" }
  end
end

