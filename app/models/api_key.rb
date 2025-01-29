class ApiKey < ApplicationRecord
  before_create :generate_key

  validates :app_name, presence: true, uniqueness: true
  validates :key, presence: true, uniqueness: true

  private

  def generate_key
    self.key = SecureRandom.hex(32)
  end
end
