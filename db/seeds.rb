# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#

User.create(:name => "test_user", :pw => "pass")
Organization.create(:name => "users", :pw => "", :description => "ユーザからの投稿", :rank => 1)
Layer.create(:org_id => 1)
Disaster.create(:name => "大雨警報", :description => "避難してー")
Disaster.create(:name => "洪水警報", :description => "川の近くはだめよ")
Disaster.create(:name => "デスマ警報", :description => "逃げないと死ぬ")
