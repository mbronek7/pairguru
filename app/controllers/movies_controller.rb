class MoviesController < ApplicationController
  before_action :authenticate_user!, only: [:send_info, :export]

  def index
    @movies = Movie.page(params[:page]).per(10).decorate
  end

  def show
    @movie = Movie.find(params[:id]).decorate
  end

  def send_info
    @movie = Movie.find(params[:id])
    MovieInfoMailer.send_info(current_user, @movie).deliver_later
    redirect_back(fallback_location: root_path, notice: "Email sent with movie info")
  end

  def export
    MoviesExportJob.perform_later(current_user.id)
    redirect_to root_path, notice: "Movies exported"
  end
end
