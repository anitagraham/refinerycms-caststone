# frozen_string_literal: true

module Refinery
  module Caststone
    module Admin
      class ComponentsPresenter
        include ActionView::Helpers::TagHelper
        include ActionView::Helpers::FormHelper

        attr_accessor :collection, :output_buffer

        def initialize(collection)
          @collection = collection
        end

        def list_by_type
          for_component_types(@collection) do |type_name, collection|
            by_type(type_name, collection) do |type_name, subset|
              show_names(type_name, subset)
            end
          end
        end

        def list_by_type_as_checkboxes
          for_component_types(@collection) do |type_name, collection|
            by_type(type_name, collection) do |type_name, subset|
              component_checkboxes(type_name, subset)
            end
          end
        end

        private

          def for_component_types(components)
            lists = []
            Refinery::Caststone::Component::COMP_TYPES.each do |type|
              lists << yield(type, components)
            end
            lists.join(' ').html_safe
          end

          def by_type(type_name, components)
            type_class = model_class(type_name)
            type_subset = components.select { |component| type_class === component.type }
            yield(type_name, type_subset)
          end

          def show_names(type_name, components)
            return unless components.any?
            list_items = components.each.reduce(ActiveSupport::SafeBuffer.new) do |buffer, component|
              buffer << tag.li(component.name)
            end
            html = []
            html.push tag.h3 plural_type(type_name)
            html.push tag.ul list_items
            tag.div(html.join(' ').html_safe, class: :component_type)
          end

          def model_class(component_type)
            "Refinery::Caststone::#{component_type}"
          end

          def plural_type(type)
            type.pluralize
          end

          def form_id(type_name)
            "#{type_name}_ids".to_sym
          end
      end
    end
  end
end
