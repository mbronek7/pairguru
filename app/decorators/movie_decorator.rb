class MovieDecorator < Draper::Decorator
  delegate_all

  def cover
    Pairguru::Base::ENDPOINT + attributes[:poster]
  end

  def plot
    attributes[:plot]
  end

  def rating
    attributes[:rating]
  end

  private

  def attributes
    @attributes ||= Pairguru::Resources::Movies.build.get(object.title)[:attributes]
  end
end
