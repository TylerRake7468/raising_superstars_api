module Api
	module V1
		class DailyActivitiesController < ApplicationController
			before_action :set_day
			before_action :set_user
			before_action :set_user_completions

			def index
				render json: build_day_activity_response, status: :ok
			end

			private

			def set_day
				@day = Day.find_by(id: params[:day_id])
				render json: {error: "Day not found"}, statue: :not_found unless @day.present?
			end

			def set_user
				@user = User.find_by(id: params[:user_id])
				render json: {error: "User not found"}, statue: :not_found unless @user.present?
			end

			def set_user_completions
				daily_activity_ids = @day.daily_activities.pluck(:id)
				@completed_ids = Completion.where(user_id: @user.id, daily_activity_id: daily_activity_ids).pluck(:daily_activity_id).to_set
			end

			def build_day_activity_response
				{
				  day_id: @day.id,
				  day_number: @day.day_number,
				  program_id: @day.program_id,
				  activities: formatted_activities
				}
			end

			def formatted_activities
				@day.daily_activities.includes(activity: :category).map do |daily_activity|
				activity = daily_activity.activity
					{
						daily_activity_id: daily_activity.id,
						activity_id: activity.id,
						name: activity.title,
						category: activity.category.name,
						frequency: activity.frequency,
						duration_in_sec: activity.duration_in_sec,
						completed: @completed_ids.include?(daily_activity.id)
					}
				end
			end
		end
	end
end
