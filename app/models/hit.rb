class Hit < ApplicationRecord
  belongs_to :link, counter_cache: true
  validates :ip_address, :location, presence: true
end
