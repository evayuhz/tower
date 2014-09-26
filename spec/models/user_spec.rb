require 'rails_helper'

RSpec.describe User, :type => :model do
  before {
    @user = User.new(name: 'eva',
                     email: 'evayuhz@gmail.com',
                     password: 'foobar',
                     password_confirmation: 'foobar')
  }

  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:remember_token) }
  it { should respond_to(:authenticate) }
  it { should respond_to(:admin) }
end
