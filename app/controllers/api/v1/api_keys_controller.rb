class Api::V1::ApiKeysController < ApplicationController
  def create
    app_name = api_key_params[:app_name]

    if app_name.blank?
      render json: { error: 'App name is required' }, status: :unprocessable_entity
      return
    end

    api_key = ApiKey.create!(app_name: app_name)

    render json: { api_key: api_key.key, app_name: api_key.app_name }, status: :created
  end

  private

  def api_key_params
    params.require(:api_key).permit(:app_name)
  end
end
