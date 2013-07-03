class Proficiency < ActiveRecord::Base
	validates :years, :presence => true
	validates :formal, :inclusion => {:in => [true, false]}

	belongs_to :skill
	belongs_to :user
end
