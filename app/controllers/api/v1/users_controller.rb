module Api
	module V1
		class UsersController < ApplicationController
			before_action :set_user, only: [:progress]

			def progress
				programs = Program.includes(days: {daily_activities: :activity})
				if params[:program_id].present?
					programs = programs.where(id: params[:program_id])
				end

				render json: {user_id: @user.id, progress: get_all_programs_progress(programs)}, statue: :ok
			rescue ActiveRecord::RecordNotFound
				render json: {error: "User or Progress details not found"}, status: :not_found
			end

			private

			def get_all_programs_progress(programs)
				programs_progress = programs.map do |program|
					day_stats = get_day_stats(program)
					total_day = day_stats.size
					completed_days = day_stats.select{|d| d[:completed]==true }.count
					{
						program_id: program.id,
						program_name: program.name,
						total_days: total_day,
						completed_days: completed_days,
						overall_completion_percentage: total_day > 0 ? ((completed_days.to_f / total_day) * 100).round(2) : 0.0,
						days: day_stats
					}
				end

			end

			def get_day_stats(program)
				program.days.map do |day|
					daily_activities = day.daily_activities
					total_acitvity = daily_activities.size
					completed_ids = Completion.where(user_id: @user.id, daily_activity_id: daily_activities.pluck(:id)).pluck(:daily_activity_id).to_set
					completed_count = completed_ids.size

					{
						day_id: day.id,
						day_number: day.day_number,
						total_acitvities: total_acitvity,
						completed_activities: completed_count
					}
				end
			end

			def set_user
				@user = User.find_by(id: params[:user_id])
				render json: {error: "User not found"}, statue: :not_found unless @user.present?
			end
		end
	end
end