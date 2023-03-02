require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: 'Tom', photo: 'https://unsplash.com/photos', bio: 'Teacher from Mexico.') }
  before { subject.save }

  it 'name should be present' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'post counter should be integer' do
    subject.post_counter = 'number'
    expect(subject).to_not be_valid
  end

  it 'post counter should be greater than zero' do
    subject.post_counter = '-1'
    expect(subject).to_not be_valid
  end

  it 'post counter should be equal to zero' do
    subject.post_counter = 0
    expect(subject).to be_valid
  end

  it 'post counter should be greather than zero' do
    subject.post_counter = 2
    expect(subject).to be_valid
  end
end
