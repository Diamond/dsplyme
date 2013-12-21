require 'spec_helper'

describe Group do
  subject { FactoryGirl.build(:group) }
  it { should be_valid }
end
