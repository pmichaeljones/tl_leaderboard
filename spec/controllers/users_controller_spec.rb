require 'spec_helper'

describe UsersController do

  decribe 'GET index' do

    it 'sets the @users variable'

    it 'renders the index template'

  end

  describe 'GET update_users' do

    it 'sets the @users variable'

    it 'renders the index template'

  end


  describe "POST create" do

    context 'within invalid inputs' do

      it 'doe not create a new user'

      it 'redirects to the index action'

      it 'sets flash on unsuccessful save'

    end #end invalid inputs context

    context 'with valid inputs but invalid github username' do

        it 'doesnt create a user if github user does not exist'

        it 'sets username doesnt exist flash message'

        it 'redirects to index action'

    end #end valid inputs but invalid github username

    context 'with valid inputs and valid github username' do

      it 'create a user if a github user exits'

      it 'sets the @users variable'

      it 'sets flash on successful save'

      it 'sets the flash success message'

    end #end valid inputs and valid github username

  end

end