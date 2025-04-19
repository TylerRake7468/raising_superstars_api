module Api
	module V1
		class ProgramsController < ApplicationController
			def index
				programs = Program.all
				render json: programs, status: :ok
			end

			def show
				program = Program.includes(days: {daily_activities: :activity}).find_by(id: params[:id])
				if program.present?
					render json: program.as_json(include: {days: {include: {daily_activities: {include: :activity}}}}), status: :ok
				else
					render json: {error: "Record Not Found"}, status: :not_found
				end
			end
		end
	end
end