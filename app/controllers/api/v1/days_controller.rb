module Api
	module V1
		class DaysController < ApplicationController
			def index
				program = Program.find_by(id: params[:program_id])
				days = program.days.order(:day_number) if program.present?
				if days.present?
					render json: days, status: :ok
				else
					render json: {error: "Program not found."}, status: :not_found
				end
			end

			def show
				day = Day.includes(daily_activities: {activity: :category}).find_by(id: params[:id])
				if day.present?
			        render json: {
			          id: day.id,
			          day_number: day.day_number,
			          program_id: day.program_id,
			          activities: get_day_activities_json(day)
			        }, status: :ok
				else
					render json: {error: "Program not found."}, status: :not_found
				end
			end

			private

			def get_day_activities_json(day)
		        activities = day.daily_activities.map do |da|
					activity = da.activity
					{
						id: activity.id,
						name: activity.title,
						category: activity.category.name,
						frequency: activity.frequency,
						duration_in_sec: activity.duration_in_sec
					}
				end
			end
		end
	end
end