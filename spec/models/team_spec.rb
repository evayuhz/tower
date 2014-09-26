require 'rails_helper'

RSpec.describe Team, :type => :model do
  before {
    @team = build(:team)
  }
  subject { @team }

  it { should respond_to(:name) }
  it { should respond_to(:leader)}

  it { should be_valid }
end
