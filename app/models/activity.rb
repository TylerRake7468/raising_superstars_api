class Activity < ApplicationRecord
  belongs_to :category
  has_many :daily_activities, dependent: :destroy

end
