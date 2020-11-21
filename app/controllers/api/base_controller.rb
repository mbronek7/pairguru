module Api
  class BaseController < ActionController::API
    include PaginationConcern

    rescue_from ActiveRecord::RecordNotFound do
      render_error_payload(:not_found, status: :not_found)
    end
  end
end
