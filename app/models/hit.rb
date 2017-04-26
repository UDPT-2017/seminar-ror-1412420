class Hit < ApplicationRecord
  belongs_to :link, counter_cache: true
  geocoded_by :address
  after_validation :geocode

  private

  def address
    ip_address
  end
end
