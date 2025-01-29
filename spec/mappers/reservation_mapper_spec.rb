require 'rails_helper'

RSpec.describe ReservationMapper, type: :mapper do
  describe '.map' do
    context 'when given an Airbnb payload' do
      let(:airbnb_payload) { build(:airbnb_payload) }

      it 'correctly maps the reservation attributes' do
        mapped_data = ReservationMapper.map(airbnb_payload)

        expect(mapped_data[:start_date]).to eq('2021-03-12')
        expect(mapped_data[:end_date]).to eq('2021-03-16')
        expect(mapped_data[:nights]).to eq(4)
        expect(mapped_data[:guests]).to eq(4)
        expect(mapped_data[:adults]).to eq(2)
        expect(mapped_data[:children]).to eq(2)
        expect(mapped_data[:infants]).to eq(0)
        expect(mapped_data[:status]).to eq('accepted')
        expect(mapped_data[:currency]).to eq('AUD')
        expect(mapped_data[:payout_price]).to eq('3800.00')
        expect(mapped_data[:security_price]).to eq('500')
        expect(mapped_data[:total_price]).to eq('4500.00')
        expect(mapped_data[:guest][:id]).to eq(1)
        expect(mapped_data[:guest][:first_name]).to eq('Wayne')
        expect(mapped_data[:guest][:last_name]).to eq('Woodbridge')
        expect(mapped_data[:guest][:phone]).to eq('639123456789')
        expect(mapped_data[:guest][:email]).to eq('wayne_woodbridge@bnb.com')
      end
    end

    context 'when given a Booking.com payload' do
      let(:booking_com_payload) { build(:booking_com_payload) }

      it 'correctly maps the reservation attributes' do
        mapped_data = ReservationMapper.map(booking_com_payload)

        expect(mapped_data[:start_date]).to eq('2021-03-12')
        expect(mapped_data[:end_date]).to eq('2021-03-16')
        expect(mapped_data[:nights]).to eq(4)
        expect(mapped_data[:guests]).to eq(4)
        expect(mapped_data[:adults]).to eq(2)
        expect(mapped_data[:children]).to eq(2)
        expect(mapped_data[:infants]).to eq(0)
        expect(mapped_data[:status]).to eq('accepted')
        expect(mapped_data[:currency]).to eq('AUD')
        expect(mapped_data[:payout_price]).to eq('3800.00')
        expect(mapped_data[:security_price]).to eq('500.00')
        expect(mapped_data[:total_price]).to eq('4500.00')
        expect(mapped_data[:guest][:id]).to eq(1)
        expect(mapped_data[:guest][:first_name]).to eq('Wayne')
        expect(mapped_data[:guest][:last_name]).to eq('Woodbridge')
        expect(mapped_data[:guest][:phone]).to eq('639123456789')
        expect(mapped_data[:guest][:email]).to eq('wayne_woodbridge@bnb.com')
      end
    end
  end
end
