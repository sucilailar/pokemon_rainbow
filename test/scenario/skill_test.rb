require 'test_helper'

class SkillTest < ActiveSupport::TestCase

	def setup
		@skill = Skill.new(name: "Example Skill", power: 30, max_pp: 30,
			element_type: "water")
	end

	test "skill should be valid" do
		assert @skill.valid?
	end

	test "name should be present" do	
		@skill.name = " "
		assert_not @skill.valid?
	end

	test "power should be present" do
		@skill.power = " "
		assert_not @skill.valid?
	end

	test "maxpp should be present" do
		@skill.max_pp = " "
		assert_not @skill.valid?
	end

	test "name should be unique" do
		duplicate_skill = @skill.dup
    duplicate_skill.name = @skill.name
  	@skill.save
  	assert_not duplicate_skill.valid?
	end

	test "element type should be inclusion" do 
		@skill.element_type = "air"
		assert_not @skill.valid?
	end

	test "name length maximum 45" do
		@skill.name = "a" * 50
		assert_not @skill.valid?
	end

	test "element type maximum 45" do
		@skill.element_type = "a" * 50
		assert_not @skill.valid?
	end

	test "power should greater than 0" do
		assert_operator @skill.power, :>, 0
	end

	test "max pp should greater than 0" do
		assert_operator @skill.power, :>, 0
	end

end
