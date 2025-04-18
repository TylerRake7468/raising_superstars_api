class Completion < ApplicationRecord
  belongs_to :user
  belongs_to :daily_activity
end
