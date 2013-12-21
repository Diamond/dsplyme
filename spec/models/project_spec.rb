require 'spec_helper'

describe Project do
  subject { FactoryGirl.build(:project) }
  it { should be_valid }

  context "When a project is added to a group" do
    let (:group) { FactoryGirl.build(:group) }
    before :each do
      subject.group = group
    end

    its(:group_id) { should eq group.group_id }
  end
end
