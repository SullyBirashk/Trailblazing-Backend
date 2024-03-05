require 'rails_helper'

RSpec.describe User, type: :model do
  # Validation tests
  it 'is valid with a name, email, and password' do
    user = User.new(
      name: 'John Doe',
      email: 'john@example.com',
      password: 'password',
      password_confirmation: 'password'
    )
    expect(user).to be_valid
  end

  it 'is invalid without a name' do
    user = User.new(name: nil)
    user.valid?
    expect(user.errors[:name]).to include("can't be blank")
  end

  it 'is invalid without an email' do
    user = User.new(email: nil)
    user.valid?
    expect(user.errors[:email]).to include("can't be blank")
  end

  it 'is invalid with a duplicate email' do
    User.create(
      name: 'Jane Doe',
      email: 'jane@example.com',
      password: 'password',
      password_confirmation: 'password'
    )
    user = User.new(
      name: 'John Doe',
      email: 'jane@example.com',
      password: 'password',
      password_confirmation: 'password'
    )
    user.valid?
    expect(user.errors[:email]).to include("has already been taken")
  end

  it 'is invalid without a password' do
    user = User.new(password: nil)
    user.valid?
    expect(user.errors[:password]).to include("can't be blank")
  end

  it 'is invalid with a password too short' do
    user = User.new(password: 'short', password_confirmation: 'short')
    user.valid?
    expect(user.errors[:password]).to include("is too short (minimum is 6 characters)")
  end
  
  it 'is invalid with an incorrect email format' do
    user = User.new(email: 'useratexampledotcom')
    user.valid?
    expect(user.errors[:email]).to include("is invalid")
  end
end
