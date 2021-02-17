require './rails_helper'

RSpec.describe Opinion do
  let(:user) { User.create(id: 2, username: 'elisha', fullname: 'user fullname') }

  let(:subject) do
    described_class.new(
      text: 'fksdfj sjdflsd',
      author: user
    )
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:author) }
    it { is_expected.to validate_presence_of(:text) }

    it 'is valid with valid attribute' do
      expect(subject).to be_valid
    end

    it 'The author of the opinion should exist' do
      subject.author = nil
      expect(subject).not_to be_valid
    end

    it 'The text of the opinion should not be shorter than 1 character' do
      subject.text = ''
      expect(subject).not_to be_valid
    end

    it 'The text of the opinion should not be longer than 100 characters' do
      subject.text = 'weiruwieruiowueriuioweuriuwioeurwiahdksahdksahdjshdjshdjshdjsahdsadhjsdhjsdh
        dhaskjdhjsahdjsahdjksahdkjsahdjsahdjksahdjksahdjksahdjsahdjahdjsadhjsahdjksahdjsahdjksadhs
        sadhjsahdjashdjksahdjkashdkkashddksahddkjsahdksoersdsadsad
        sdsadsadiushdjsahdjsahdjksdhiouiowerui'
      expect(subject).not_to be_valid
    end
  end

  describe 'Associations', type: :model do
    it { is_expected.to belong_to(:author) }
  end
end
