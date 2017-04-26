class Link < ApplicationRecord
  has_many :hits
  belongs_to :user, counter_cache: true, optional: true
  validates :full_link, :short_link, presence: true
  validates :short_link, uniqueness: true
  validates :full_link, url: true
end
