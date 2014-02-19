class Url < ActiveRecord::Base
  belongs_to :user
  require 'securerandom'
  before_save :generate_short_url
  validates :url, format: { with: /\Aw{3}\.\w+\.\w{3}\z/, message: 'Invalid URL'}
  validates :url, uniqueness: true
  validates :short_url, uniqueness: true

  def generate_short_url
    self.short_url = SecureRandom.hex(2) if short_url.nil?
  end
end
