require 'spec_helper'

describe User do
  subject { FactoryGirl.build(:user) }
  it { should be_valid }

  context "When a user joins a group" do
    let (:group) { FactoryGirl.build(:group) }

    before :each do
      subject.group = group
    end

    its(:group_id) { should eq group.group_id }
  end
end
