# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Rsa.create(
  n: '111111111',
  e:  '3',
  d:  '33',
  messages: 'My name is my name.' ,
  encrypt_messages: '35348537853483458395',
  decrypt_messages: 'My name is my name.' 
)
