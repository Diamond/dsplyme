require 'spec_helper'

describe Group do
  subject { FactoryGirl.build(:group) }
  it { should be_valid }

  context "When adding users" do
    before :each do
      @user1, @user2 = FactoryGirl.build(:user), FactoryGirl.build(:user)
      subject.users |= [@user1, @user2]
    end

    its(:users) { should eq [@user1, @user2] }
  end

  context "When adding projects" do
    before :each do
      @project1, @project2 = FactoryGirl.build(:project), FactoryGirl.build(:project)
      subject.projects |= [@project1, @project2]
    end

    its(:projects) { should eq [@project1, @project2] }
  end

  context "When created by a user" do
    before :each do
      @founder = FactoryGirl.build(:user)
      subject.founder = @founder
    end

    its(:founder) { should eq @founder }
  end
end
