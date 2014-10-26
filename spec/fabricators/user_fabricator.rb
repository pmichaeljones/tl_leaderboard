Fabricator(:user) do
  name { Faker::Name.name }
  email { Faker::Internet.email }
  github_username { Faker::Name.name }
  streak { 0 }
  contributions { 0 }
end
