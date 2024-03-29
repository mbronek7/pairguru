# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  body       :text
#  movie_id   :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Comment < ApplicationRecord
  belongs_to :movie
  belongs_to :user
  validates :body, :movie_id, :user_id, presence: true
  validates :user_id, uniqueness: { scope: :movie_id }
end
