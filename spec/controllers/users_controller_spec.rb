require 'spec_helper'

describe UsersController do

  let(:patrick) { Fabricate(:user) }
  let(:mike) { Fabricate(:user, github_username: "mikey") }

  describe 'POST send_token' do

    context 'if github user exists in our database' do

      after { ActionMailer::Base.deliveries.clear }

      it 'should flash success message' do
        patrick = Fabricate(:user)
        post :send_token, github_name: patrick.github_username
        expect(flash[:success]).to be_present
      end


      it 'should send an email to the github user on file' do
        patrick = Fabricate(:user)
        post :send_token, github_name: patrick.github_username
        expect(ActionMailer::Base.deliveries.last.to).to eq([patrick.email])
      end


      it 'should render new token template' do
        patrick = Fabricate(:user)
        post :send_token, github_name: patrick.github_username
        expect(response).to render_template :new_token
      end

    end

    context 'if github user does not exist in our db' do

      it 'should render flash error message' do
        patrick = Fabricate(:user)
        post :send_token, github_name: "wallymdjefferson"
        expect(flash[:error]).to be_present
      end

      it 'should render the new_token template' do
        patrick = Fabricate(:user)
        post :send_token, github_name: "wallymdjefferson"
        expect(response).to render_template :new_token
      end

    end

  end

  describe 'POST delete_user' do

    it 'sets @user variable' do
      user = Fabricate(:user)
      post :delete_user, user_id: user.id
      expect(assigns(:user)).to eq(user)
    end

    it 'renders the delete user template' do
      user = Fabricate(:user)
      post :delete_user, user_id: user.id
      expect(response).to render_template :delete_user
    end

  end

  describe 'POST destroy_user' do

    context 'with valid user and correct token' do

      it 'should should erase the user if input secret matches user secret' do
        user = Fabricate(:user)
        user.secret = "aabbcc"
        user.save
        post :destroy_user, user_id: user.id, secret_token: "aabbcc"
        expect(User.all.count).to eq(0)
      end

      it 'sets a flash[:success] message' do
        user = Fabricate(:user)
        user.secret = "aabbcc"
        user.save
        post :destroy_user, user_id: user.id, secret_token: "aabbcc"
        expect(flash[:success]).to be_present
      end

      it 'redirect to root path' do
        user = Fabricate(:user)
        user.secret = "aabbcc"
        user.save
        post :destroy_user, user_id: user.id, secret_token: "aabbcc"
        expect(response).to redirect_to root_path
      end

    end

    context 'with valid user and incorrect token' do

      it 'should not erase any user' do
        user = Fabricate(:user)
        user.secret = "aabbcc"
        user.save
        post :destroy_user, user_id: user.id, secret_token: "wrongtoken"
        expect(User.all.count).to eq(1)
      end

      it 'sets a flash[:error] message' do
        user = Fabricate(:user)
        user.secret = "aabbcc"
        user.save
        post :destroy_user, user_id: user.id, secret_token: "wrongtoken"
        expect(flash[:error]).to be_present
      end

    end

  end


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

    context 'sending emails' do

      after { ActionMailer::Base.deliveries.clear }

      it 'sends an email to the user with their delete user secret' do
        post :create, user: Fabricate.attributes_for(:user)
        expect(ActionMailer::Base.deliveries.count).to eq(1)
      end

    end


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