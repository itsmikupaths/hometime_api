require 'rails_helper'

RSpec.describe Api::V1::ReservationsController, type: :controller do
  describe 'POST #create' do

    context 'with valid payload' do
      let(:valid_payload) { build(:airbnb_payload) }
      
      it 'returns a success response' do
        expect {
          post :create, params: {}, body: valid_payload, as: :json
        }.to change(Reservation, :count).by(1).and change(Guest, :count).by(1)

        expect(response).to have_http_status(:created)
      end
      
      it 'maps the reservation attributes correctly' do
        post :create, params: {}, body: valid_payload, as: :json
        parsed_response = JSON.parse(response.body)
        expect(parsed_response['start_date']).to eq('2021-03-12')
        expect(parsed_response['guest']['phone']).to eq('639123456789')
      end
    end

    context 'with invalid payload' do
      let(:invalid_payload) { '{ invalid json }' }
      
      it 'returns an error response' do
        post :create, params: {}, body: invalid_payload, as: :json
        expect(response).to have_http_status(422) # unprocessable_entity
      end
    end
  end
end
