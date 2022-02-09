require 'rails_helper'

RSpec.describe User, type: :model do
  
  describe 'User Validations' do
    it 'password and password_confirmation fields must match' do
      @user = User.new(name: 'Robyn', email: 'badgyal@email.com', password: 'Umbrella', password_confirmation: 'Umbrella' )
      expect(@user.password).to eq(@user.password_confirmation)
    end

    it "cannot register account if email is already registered" do
      @user_1 = User.new(name: 'Robyn', email: 'badgyal@email.com', password: 'Umbrella', password_confirmation: 'Umbrella' )
      @user_1.save

      @user_2 = User.new(name: 'Robyn', email: 'badgyal@email.com', password: 'Umbrella', password_confirmation: 'Umbrella' )
      @user_2.save
      expect(User.where(email: 'badgyal@email.com').count) == 1
    end

    it "cannot register if last name is blank" do
      @user = User.new(name: 'Robyn', email: 'badgyal@email.com', password: 'Umbrella', password_confirmation: 'Umbrella' )
      @user.save
      
      expect(User.where(email: 'badgyal@email.com').count) == 0
    end
    
    it "cannot register if email is blank" do
      @user = User.new(name: nil, email: nil, password: 'Umbrella', password_confirmation: nil )
      @user.save
      
      expect(User.where(email: 'badgyal@email.com').count) == 0
    end

    it "cannot register if password is less than 7 characters" do
      @user = User.new(name: nil, email: nil, password: 'Work', password_confirmation: 'Work' )
      @user.save
      
      expect(User.where(email: 'badgyal@email.com').count) == 0
    end

    it "can register if password is 5 characters" do
      @user = User.new(name: nil, email: nil, password: 'Rehab', password_confirmation: 'Rehab' )
      @user.save
      
      expect(User.where(email: 'badgyal@email.com').count) == 1
    end
end

describe '.authenticate_with_credentials' do
  # examples for this class method here
  it 'should authenticate users if email and password match' do
    @user = User.new(name: 'Robyn', email: 'badgyal@email.com', password: 'Umbrella')
    @user.save

    expect(User.authenticate_with_credentials('badgyal@email.com', 'Umbrella')).to eq(@user)

    expect(User.authenticate_with_credentials('badgyal@email.com', '123456')).to eq(nil)

    expect(User.authenticate_with_credentials('badgyal@email.com', 'AAABBBCCC')).to eq(nil)
  end

  it 'should authenticate emails if extra spaces are added before or after' do
    @user = User.new(name: 'Robyn', email: 'badgyal@email.com', password: 'Umbrella')
    @user.save

    expect(User.authenticate_with_credentials(' badgyal@email.com ', 'Umbrella')).to eq(@user)
  end

  it 'should authenticate email if email is different case' do
    @user = User.new(name: 'Robyn', email: 'badgyal@email.com', password: 'Umbrella')
    @user.save

    expect(User.authenticate_with_credentials(' BADgyal@email.com ', 'Umbrella')).to eq(@user)
  end

end

end 