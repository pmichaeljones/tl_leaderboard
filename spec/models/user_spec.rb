require 'spec_helper'

describe User do

  it { should validate_presence_of :name }
  it { should validate_presence_of :github_username }
  it { should validate_presence_of :contributions }
  it { should validate_presence_of :streak }

end
