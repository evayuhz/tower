require 'rails_helper'

RSpec.describe Project, :type => :model do
  before {
    @project = build(:project)
  }

  subject { @project }

  it { should respond_to(:name) }
  it { should respond_to(:team) }
  it { should be_valid }
end
