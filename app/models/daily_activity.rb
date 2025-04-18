class DailyActivity < ApplicationRecord
  belongs_to :day
  belongs_to :activity
  has_many :completions, dependent: :destroy
end
