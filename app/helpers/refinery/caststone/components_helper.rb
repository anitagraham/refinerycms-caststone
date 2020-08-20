# module Caststone
#   module ComponentsHelper
#     include ActionView::Helpers::TagHelper
#
#       def list_component_names(components)
#         for_component_types(components) do |typeName, components|
#           by_type(typeName, components) { |subset| show_names(subset)}
#         end
#       end
#
#       def for_component_types(components)
#         Refinery::Caststone::Component::COMP_TYPES.each do |type|
#           yield(type, components)
#         end
#       end
#
#       def model_class(type)
#         "Refinery::Caststone::#{type}"
#       end
#
#       def plural_type(type)
#         type.pluralize
#       end
#
#       def by_type(typeName, components)
#         current_type = components.select { |component| model_class(typeName) === component.type }
#         if current_type.any?
#           yield(current_type)
#         end
#       end
#
#       def show_names(components)
#         html = []
#         html.push tag.h3 plural_type(type)
#         html.push tag.ul do
#           components.reduce(ActiveSupport::SafeBuffer.new) do |buffer, component|
#             buffer << tag.li(component.name)
#           end
#         end
#         html.join(' ').html_safe
#       end
#
#   end
# end
#
#
