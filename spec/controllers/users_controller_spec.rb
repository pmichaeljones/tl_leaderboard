require 'spec_helper'

describe UsersController do

  describe "POST create" do
    it 'doesnt create a user if net/http returns a 404' do
      post :create, name: "Patrick", github_username: "adfasdfdfaasdf"
      expect(User.all.count).to eq(0)
    end

    it 'create a user if a github user exits' do
      post :create, name: "Patrick", github_username: "pmichaeljones"
      expect(User.all.count).to eq(1)
    end



    it 'sets the @users variable'
  end



end
