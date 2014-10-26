require 'spec_helper'

describe UsersController do

  describe "POST create" do

    context 'within invalid inputs' do

      it 'doesnt create a user if net/http returns a 404' do
        patrick = Fabricate(:user, github_username: 'xdfdfasdfdfsdf')
        binding.pry
        post :create, user: patrick
        expect(User.all.count).to eq(0)
      end

      it 'sets flash on unsuccessful save' do

      end

    end

    context 'with valid inputs' do

      it 'create a user if a github user exits' do

        post :create, name: "Patrick", github_username: "pmichaeljones", email: 'pj@example.com'
        expect(User.all.count).to eq(1)
      end


      it 'sets the @users variable' do

      end


      it 'sets flash on successful save' do

      end

       it 'sets username doesnt exist flash' do
        post :create, name: "Patrick", github_username: "pmichaeljonesxyz", github_username_confirmation: "pmichaeljonesxyz"
        expect(Flash[:alert]).to eq("Username doesn't exist")
      end

    end

  end

end