class DailyActivity < ApplicationRecord
  belongs_to :day
  belongs_to :activity
end
