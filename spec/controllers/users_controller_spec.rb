require 'spec_helper'

describe UsersController do

  let(:patrick) { Fabricate(:user) }
  let(:mike) { Fabricate(:user) }

  describe 'GET update_users' do

    it 'sets the @users variable' do
      get :index
      expect(assigns(:users)).to include(mike, patrick)
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template :index
    end

  end

  describe 'GET index' do

    it 'sets the @users variable' do
      get :index
      expect(assigns(:users)).to include(mike, patrick)
    end


    it 'renders the index template' do
      get :index
      expect(response).to render_template :index
    end

  end


  describe "POST create" do

    context 'with invalid inputs' do

      it 'renders the index template' do
        post :create, user: { name: "Patrick" }
        expect(response).to render_template :index
      end

      it 'does not create a new user' do
        post :create, user: {name: "Patrick"}
        expect(User.all.count).to eq(0)
      end

      it 'sets flash on unsuccessful save' do
        post :create, user: {name: "Patrick"}
        expect(flash).to be_present
      end

    end #end invalid inputs context

    context 'with valid inputs and valid github username' do

      before do
        post :create, user: Fabricate.attributes_for(:user)
      end

      it 'saves user' do
        expect(User.all.count). to eq(1)
      end

      it 'sets the @users variable' do
        expect(assigns(:users).count).to eq(2)
      end

      it 'sets flash on successful save'

      it 'sets the flash success message'

    end #end valid inputs and valid github username

    context 'with valid inputs but invalid github username' do

      # it 'doesnt create a user if github user does not exist' do
      #   patrick = Fabricate(:user, github_username: 'xdfdfasdfdfsdf')
      #   post :create, user: patrick
      #   expect(User.all.count).to eq(0)
      # end

        it 'sets username doesnt exist flash message'

        it 'redirects to index action'

    end #end valid inputs but invalid github username

  end

end