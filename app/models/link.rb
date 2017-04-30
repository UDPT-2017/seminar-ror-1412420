class Link < ApplicationRecord
  has_many :hits
  enum link_type: [ :short, :full ]

  belongs_to :user, counter_cache: true, optional: true
  validates :full_link, :short_link, :link_type, presence: true
  validates :short_link, uniqueness: true, if: :short?
  validates :full_link, url: true

  default_scope -> { where(link_type: 0).order(id: :desc) }

end
