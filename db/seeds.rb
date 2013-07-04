
require 'faker'

# create a few users
User.create :name => 'Dev Bootcamp Student', :email => 'me@example.com', :password => 'password'
5.times do
  User.create :name => Faker::Name.name, :email => Faker::Internet.email, :password => 'password'
end

# create a few technical skills
computer_skills = %w(Ruby Sinatra Rails JavaScript jQuery HTML CSS)
computer_skills.each do |skill|
  Skill.create :name => skill, :context => 'technical'
end

# create a few creative skills
design_skills = %w(Photoshop Illustrator Responsive-Design)
design_skills.each do |skill|
  Skill.create :name => skill, :context => 'creative'
end

skills = computer_skills + design_skills
user_ids = (1..5).to_a
skill_ids = (1..10).to_a
# TODO: create associations between users and skills

proficiency_true_or_false = [0,1]

25.times do |proficiency|
	Proficiency.create(:user_id => user_ids.sample,
										 :skill_id => skill_ids.sample,
										 :years => user_ids.sample,
										 :formal => proficiency_true_or_false.sample)
end
