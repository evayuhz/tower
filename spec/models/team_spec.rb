require 'rails_helper'

RSpec.describe Team, :type => :model do
  before {
    @team = build(:team)
  }
  subject { @team }

  it { should respond_to(:name) }
  it { should respond_to(:leader) }
  it { should respond_to(:projects) }

  it { should be_valid }
end
