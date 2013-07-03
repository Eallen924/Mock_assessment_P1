class CreateTableProficiencies < ActiveRecord::Migration
  def change
  	create_table :proficiencies do |t|
  		t.integer :user_id
  		t.integer :skill_id
  		t.integer :years
  		t.boolean :formal
  	end
  end
end
