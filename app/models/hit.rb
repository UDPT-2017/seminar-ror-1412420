class Hit < ApplicationRecord
  belongs_to :link, counter_cache: true
  # geocoded_by :address
  # after_validation :geocode

  private

  def address
    ip_address
  end

  class << self
    def group_by_date_within_days(days)
      where("date(created_at) >= date(?)",days.days.ago).group("date(created_at)").count
    end

    def group_by_location
      group(:location).count
    end

    def group_by_ip
      group(:ip_address).count
    end
  end
end
