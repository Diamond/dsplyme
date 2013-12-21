require 'spec_helper'

describe Project do
  subject { FactoryGirl.build(:project) }
  it { should be_valid }
end
