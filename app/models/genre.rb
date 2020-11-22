# == Schema Information
#
# Table name: genres
#
#  id           :integer          not null, primary key
#  name         :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  movies_count :integer
#

class Genre < ApplicationRecord
  has_many :movies
end
