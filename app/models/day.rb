class Day < ApplicationRecord
  belongs_to :program
  has_many :daily_activities, dependent: :destroy
end
