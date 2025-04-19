module Api
	module V1
		class CompletionsController < ApplicationController
			def index
				completions = Completion.where(user_id: params[:user_id]).includes(daily_activity: {activity: :category})
				render json: completions.map{|c| format_completion(c)}, statue: :ok
			end

			def create
				completion = Completion.new(completion_params)
				completion.completed_at = Time.now
				if completion.save
					render json: {message: "Activity marked as completed", id: completion.id}, statue: :created
				else
					render json: {error: completion.error.full_messages}, status: :unprocessable_entity
				end
			end

			def destroy
				completion = Completion.find_by(id: params[:id])
				completion.destroy
				render json: {message: "Completion removed"}, statue: :ok
			rescue ActiveRecord::RecordNotFound
				render json: {error: "Completion not found"}, status: :not_found
			end

			private

			def completion_params
				params.require(:completion).permit(:user_id, :daily_activity_id)
			end

			def format_completion(completion)
				activity = completion.daily_activity.activity
				{
					id: completion.id,
					day_id: completion.daily_activity.day_id,
					daily_activity_id: completion.daily_activity_id,
					activity_name: activity.title,
					category: activity.category.name,
					completed_at: completion.completed_at
				}
			end
		end
	end
end