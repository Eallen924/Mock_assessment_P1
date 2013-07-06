class Proficiency < ActiveRecord::Base
	validates :years, :presence => true
	validates :formal, :inclusion => {:in => [true, false]}
	validates_uniqueness_of :user_id, scope: :skill_id

	belongs_to :skill
	belongs_to :user

	def formal=(formal)
		if formal.is_a? String
			write_attribute(:formal, formal.downcase == "true")
		else
			super
		end
	end
end
