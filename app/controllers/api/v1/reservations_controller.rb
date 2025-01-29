class Api::V1::ReservationsController < ApplicationController
  def create
    payload = request.body.read
    
    mapped_data = ReservationMapper.map(payload)

    render json: { mapped_data: mapped_data }, status: :created
  end
end
