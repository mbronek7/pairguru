class ResetAllGenreCacheCounters < ActiveRecord::Migration[5.2]
  def up
    Genre.all.each do |genre|
      Genre.reset_counters(genre.id, :movies)
    end
  end

  def down;end
end
