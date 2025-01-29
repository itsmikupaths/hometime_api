class ApplicationController < ActionController::API
  private

  def authenticate_api_key
    api_key = request.headers['X-API-Key']
    
    unless api_key.present? && ApiKey.exists?(key: api_key)
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end
end
