class Api::V1::HealthCheckController < ApplicationController
  def index
    render json: { message: "V1 is up and running" }, status: :ok
  end
end