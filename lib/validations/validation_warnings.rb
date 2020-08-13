# Define a "warnings" validation bucket on ActiveRecord objects.
# https://stackoverflow.com/questions/24628628/efficient-way-to-report-record-validation-warnings-as-well-as-errors
# @example
#
#   class MyObject < ActiveRecord::Base
#     warning do |vehicle_asset|
#       unless vehicle_asset.description == 'bob'
#         vehicle_asset.warnings.add(:description, "should be 'bob'")
#       end
#     end
#   end
#
# THEN:
#
#   my_object = MyObject.new
#   my_object.description = 'Fred'
#   my_object.sensible? # => false
#   my_object.warnings.full_messages # => ["Description should be 'bob'"]

module Warnings
  module Validations
    extend ActiveSupport::Concern
    include ActiveSupport::Callbacks

    included do
      define_callbacks :warning
    end

    module ClassMethods
      def warning(*args, &block)
        options = args.extract_options!
        if options.key?(:on)
          options = options.dup
          options[:if] = Array.wrap(options[:if])
          options[:if] << "validation_context == :#{options[:on]}"
        end
        args << options
        set_callback(:warning, *args, &block)
      end
    end

    # Similar to ActiveModel::Validations#valid? but for warnings
    def sensible?
      warnings.clear
      run_callbacks :warning
      warnings.empty?
    end

    # Similar to ActiveModel::Validations#errors but returns a warnings collection
    def warnings
      @warnings ||= ActiveModel::Errors.new(self)
    end
  end
end

ActiveRecord::Base.send(:include, Warnings::Validations)
