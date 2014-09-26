require 'rails_helper'

RSpec.describe Todo, :type => :model do
  before {
    @todo = build(:todo)
  }

  subject { @todo }

  it { should respond_to(:content) }
  it { should respond_to(:assigned_user) }
  it { should respond_to(:author) }
  it { should respond_to(:status) }
  it { should respond_to(:priority) }

  it { should be_valid }
end
