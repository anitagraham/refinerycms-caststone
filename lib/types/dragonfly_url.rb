# frozen_string_literal: true

class DragonflyUrl < ActiveRecord::Type::String
  def cast()

    if value.present?
      if value.kind_of? Integer
        value
      else
        if value.kind_of?(String)
          mm, ss = value.split(SEPARATOR)
          mm.to_i * 60 + ss.to_i
        end
      end
    end
  end

  def deserialize(value)
    if value.present? && value.kind_of?(Integer)
      mm, ss = value.divmod(60)
      format("%02d",mm) + SEPARATOR + format("%02d",ss)
    end
  end
end


