class GenreDecorator < ApplicationDecorator
  delegate_all
  decorates_association :movies
end
