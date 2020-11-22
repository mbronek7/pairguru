class TitleBracketsValidator < ActiveModel::Validator
  def validate(record)
    stack = []
    empty = false
    symbols = { "{" => "}", "[" => "]", "(" => ")" }

    record.title.each_char do |c|
      if symbols.key?(c)
        empty = true
        stack << c
      elsif symbols.key(c)
        if symbols.key(c) != stack.pop
          record.errors[:title] << "Invalid brackets"
          break
        elsif empty
          record.errors[:title] << "Invalid brackets - cannot be empty"
          break
        end
      else
        empty = false
      end
    end

    unless stack.empty?
      record.errors[:title] << "Invalid brackets"
    end
  end
end
