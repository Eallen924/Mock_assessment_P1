class Skill < ActiveRecord::Base
  VALID_CONTEXTS = %w(technical creative)

  validates :name, :presence => true
  validate :validate_context

  has_many :users, :through => :proficiencies
  has_many :proficiencies

  def self.addable_by(user)
    if user.skill_ids.length > 0
      where("id NOT IN (?)", user.skill_ids)
    else
      all
    end
  end

  private
  def validate_context
    p self.context
    self.errors[:context] = "must be one of: #{VALID_CONTEXTS.join(', ')}" unless VALID_CONTEXTS.include? self.context
  end
end
