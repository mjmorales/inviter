puts '-> Creating Users'
bob = User.create!(name: 'bob')
User.create!(name: 'mary')

puts '-> Creating Party'
Party.create!(location: "bob's house", users: [bob])
