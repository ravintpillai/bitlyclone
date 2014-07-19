class Shortener < ActiveRecord::Base
	validates :code, :target_url, presence: true
	validate :code, uniqueness: true
end
