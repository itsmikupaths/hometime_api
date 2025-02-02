class Api::V1::ReservationsController < ApplicationController
  before_action :authenticate_api_key, only: [:create]

  def create
    payload = request.body.read

    begin
      mapped_data = ReservationMapper.map(payload)
    rescue => e
      render json: { error: e.message }, status: :unprocessable_entity
      return
    end

    begin
      guest = Guest.find_or_create_by!(email: mapped_data[:guest][:email]) do |g|
        g.first_name = mapped_data[:guest][:first_name]
        g.last_name = mapped_data[:guest][:last_name]
        g.phone = mapped_data[:guest][:phone]
      end

      reservation = Reservation.create!(
        start_date: mapped_data[:start_date],
        end_date: mapped_data[:end_date],
        nights: mapped_data[:nights],
        guests: mapped_data[:guests],
        adults: mapped_data[:adults],
        children: mapped_data[:children],
        infants: mapped_data[:infants],
        status: mapped_data[:status],
        currency: mapped_data[:currency],
        payout_price: mapped_data[:payout_price],
        security_price: mapped_data[:security_price],
        total_price: mapped_data[:total_price],
        guest_id: guest.id
      )

      render json: reservation.as_json.merge(guest: guest.as_json), status: :created
    rescue ActiveRecord::RecordInvalid => e
      render json: { error: "Record invalid: #{e.message}" }, status: :unprocessable_entity
    end
  end

  def index
    reservations = Reservation.includes(:guest).all

    render json: reservations, include: :guest, status: :ok
  end

  def show
    reservation = Reservation.find_by(id: params[:id])

    if reservation.nil?
      render json: { error: 'Reservation not found' }, status: :not_found
      return
    end

    guest = reservation.guest

    render json: reservation.as_json.merge(guest: guest.as_json), status: :ok
  end
end
