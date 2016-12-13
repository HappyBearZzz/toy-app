# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
admin = Admin.create([{ name: 'dave1' , hashed_password: '45c1ca4e9594740e74ae6a424515fec5456876914a30f45ddcd0b3bfc5cacfab', salt: '702605468233400.3770001453357442'}])
