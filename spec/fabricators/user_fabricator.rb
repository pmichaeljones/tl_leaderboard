Fabricator(:user) do
  name { Faker::Name.name }
  email { Faker::Internet.email }
  github_username { "pmichaeljones" }
  streak { 0 }
  contributions { 0 }
end
