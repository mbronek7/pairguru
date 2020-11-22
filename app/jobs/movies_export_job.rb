class MoviesExportJob < ApplicationJob
  queue_as :default

  def perform(user_id)
    user = User.find(user_id)
    file_path = "tmp/movies.csv"
    MovieExporter.new.call(user, file_path)
  end
end
