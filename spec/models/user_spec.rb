require 'spec_helper'

describe User do

  it { should validate_presence_of :name }
  it { should validate_presence_of :github_username }
  it { should validate_presence_of :github_username_confirmation }

  describe "#get_contributions" do

    it 'finds user on github and returns contribution string' do
      user = Fabricate(:user, name:'patrick', github_username:"pmichaeljones", github_username_confirmation:"pmichaeljones")
      expect(user.get_contributions).to be_kind_of(String)
    end

  end

  describe '#get_streak' do

    it 'finds the users current streak numnber' do
      user = Fabricate(:user, name:'patrick', github_username:"pmichaeljones", github_username_confirmation:"pmichaeljones")
      expect(user.get_streak).to be_kind_of(String)
    end

  end


end
