# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)



# Populando tabela User

#300.times do |i|
#   user = User.new
# 
#   user.screen_name = Faker::Name.first_name
#   user.email       = Faker::Internet.email
#   user.password    = user.screen_name.downcase
#
#   User.create(screen_name: "#{user.screen_name}", email: "#{user.email}", password: "#{user.password}")
#end



# Populando Table Spec
#
# user = User.all
# spec = Spec.new
#
# user.each do |usuario|
#	spec.last_name = Faker::Name.last_name
#	spec.occupation= Faker::Name.title
#	spec.city      = Faker::Address.city
#	spec.state	   = Faker::Address.state
# 	Spec.create(user_id: "#{usuario.id}", first_name: "#{usuario.screen_name}", last_name: "#{spec.last_name}",occupation: "#{spec.occupation}", city: "#{spec.city}", state: "#{spec.state}", zip_code: "12356")
# end


# Populando Tabel Faq
# 
 user = User.all
 faq  = Faq.new

user.each do |usuario|
	faq.bio       = Faker::Lorem.paragraph
	faq.skillz    = Faker::Lorem.paragraph
	faq.schools   = Faker::Lorem.paragraph
	faq.companies = Faker::Lorem.paragraph
	faq.music     = Faker::Lorem.sentence
	faq.movies    = Faker::Lorem.paragraph
	faq.television = Faker::Lorem.paragraph
	faq.magazines = Faker::Lorem.words
	faq.books     = Faker::Lorem.words
	#Faq.create(user_id: "#{usuario.id}", bio: "#{faq.bio}")
	Faq.create(user_id: "#{usuario.id}", bio: "#{faq.bio}", skillz: "#{faq.skillz}", schools: "#{faq.schools}", companies: "#{faq.companies}", music: "#{faq.music}", movies: "#{faq.movies}", television: "#{faq.television}", magazines: "#{faq.magazines}", books: "#{faq.books}")
end