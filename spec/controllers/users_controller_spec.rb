require 'spec_helper'

describe UsersController do

  let(:patrick) { Fabricate(:user) }
  let(:mike) { Fabricate(:user, github_username: "mikey") }

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
        expect(flash[:error]).to be_present
      end

    end #end invalid inputs context

    context 'with valid inputs and valid github username' do

      before do
        post :create, user: Fabricate.attributes_for(:user)
      end

      it 'redirects to root path' do
        expect(response).to redirect_to root_path
      end

      it 'saves user' do
        expect(User.all.count). to eq(1)
      end

      it 'sets the @users variable' do
        expect(assigns(:users).count).to eq(1)
      end

      it 'sets flash on successful save' do
        expect(flash[:success]).to be_present
      end

    end #end valid inputs and valid github username

    context 'with valid inputs but invalid github username' do

      it 'doesnt create a user if github user does not exist' do
        attributes = Fabricate.attributes_for(:user, github_username: 'xxccvvddsdf')
        post :create, user: attributes
        expect(User.all.count).to eq(0)
      end


      it 'sets username doesnt exist flash message' do
        attributes = Fabricate.attributes_for(:user, github_username: 'xxccvvddsdf')
        post :create, user: attributes
        expect(flash[:error]).to be_present
      end


      it 'redirects to index action' do
        attributes = Fabricate.attributes_for(:user, github_username: 'xxccvvddsdf')
        post :create, user: attributes
        expect(response).to render_template :index
      end


    end #end valid inputs but invalid github username

  end

end