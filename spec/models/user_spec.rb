require 'spec_helper'

describe User do

  it { should validate_presence_of :name }
  it { should validate_presence_of :email }
  it { should validate_presence_of :github_username }
  it { should validate_uniqueness_of :github_username }


  describe "#github_contributions" do

    it 'finds user on github and returns contribution integer' do
      user = Fabricate(:user, github_username:"pmichaeljones")
      expect(user.github_contributions).to be_kind_of(Integer)
    end

  end

  describe '#github_streak' do

    it 'finds the users current streak numnber' do
      user = Fabricate(:user, github_username:"pmichaeljones")
      expect(user.github_streak).to be_kind_of(Integer)
    end

  end

  describe '#update_user_info' do

    it 'should fetch user contributions' do
      user = Fabricate(:user, github_username:"pmichaeljones")
      user.update_user_info
      expect(user.contributions).not_to eq(0)
    end


    it 'should fetch user streak' do
      user = Fabricate(:user, github_username:"pmichaeljones")
      user.update_user_info
      expect(user.streak).not_to eq(0)
    end

  end

  describe '#github_user?' do

    it 'returns false if got a true github user' do
      user = Fabricate(:user, github_username:"pmichaeljones")
      expect(user.github_user?).to eq(true)
    end


    it 'returns true if that github name exists' do
      user = Fabricate(:user, github_username:"pmichaeljones12343234234")
      expect(user.github_user?).to eq(false)
    end

  end


end
