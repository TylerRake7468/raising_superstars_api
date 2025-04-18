class User < ApplicationRecord
	has_many :completions, dependent: :destroy
end
