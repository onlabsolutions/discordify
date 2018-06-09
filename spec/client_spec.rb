# frozen_string_literal: true

RSpec.describe Discordify::Client do
  subject { described_class.new('https://example.com/test') }

  describe '#post_json' do
    context 'with all parameters' do
      it do
        VCR.use_cassette('sucessful', record: :none) do
          expect(subject.post_json(avatar: nil, message: 'This is a test', username: 'CI')).to be_truthy
        end
      end
    end

    context 'without message' do
      it do
        VCR.use_cassette('missing_message', record: :none) do
          expect(subject.post_json(avatar: nil, message: nil, username: 'CI')).to be_falsey
        end
      end
    end

    context 'without username' do
      it do
        VCR.use_cassette('missing_username', record: :none) do
          expect(subject.post_json(avatar: nil, message: 'Test', username: nil)).to be_truthy
        end
      end
    end
  end
end
