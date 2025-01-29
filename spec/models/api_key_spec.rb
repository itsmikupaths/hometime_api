require 'rails_helper'

RSpec.describe ApiKey, type: :model do
  describe 'validations' do
    it 'is invalid without an app_name' do
      api_key = ApiKey.new(app_name: nil)
      expect(api_key.valid?).to be false
      expect(api_key.errors[:app_name]).to include("can't be blank")
    end

    it 'is invalid if app_name is not unique' do
      ApiKey.create!(app_name: 'TestApp')
      duplicate_key = ApiKey.new(app_name: 'TestApp')

      expect(duplicate_key.valid?).to be false
      expect(duplicate_key.errors[:app_name]).to include("has already been taken")
    end
  end

  describe 'callbacks' do
    it 'generates a key before creation' do
      api_key = ApiKey.create!(app_name: 'TestApp2')

      expect(api_key.key).to be_present
      expect(api_key.key.length).to eq(64) # SecureRandom.hex(32)
    end
  end
end
