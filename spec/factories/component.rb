FactoryGirl.define do
  factory :component, :class => Refinery::Caststone::Component do
    sequence(:name) { |n| "Component #{n}" }
    height 1000
    product

    factory :base,       :class => Refinery::Caststone::Base do
      type 'Refinery::Caststone::Base'
    end

    factory :shaft,      :class => Refinery::Caststone::Shaft do
      type 'Refinery::Caststone::Shaft'
    end

    factory :capital,    :class => Refinery::Caststone::Capital do
      type 'Refinery::Caststone::Capital'
    end

    factory :column,     :class => Refinery::Caststone::Column do
      type 'Refinery::Caststone::Column'
    end

    factory :letterbox,  :class => Refinery::Caststone::Letterbox do
      type 'Refinery::Caststone::Letterbox'
    end
  end

end
