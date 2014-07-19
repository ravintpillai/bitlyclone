class ShortenersController < ApplicationController

	def index
		@shorteners = Shortener.all
	end

	def show
		@shortener = load_shortener
	end

	def visit_shortened_link
		@shortener = Shortener.find_by_code(params[:code])
		redirect_to @shortener.target_url
	end

	def new
		@shortener = Shortener.new
	end

	def create
		@shortener = Shortener.new(safe_shortener_params)
		@shortener.code = shortener_code
		if @shortener.save
			redirect_to @shortener
		else
			render 'new'
		end
	end

	private
		def load_shortener
			@shortener = Shortener.find_by_id(params[:id])
		rescue ActiveRecord::RecordNotFound
			Flash.now[:notice] = "Invalid shortener Id #{params[:id]}"
			redirect_to root_path
		end

		def safe_shortener_params
			params.require('shortener').permit(:code, :target_url)
		end

		def shortener_code
			rand(10000)
		end
end