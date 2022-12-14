require 'rails_helper'

describe User do
  let(:nickname) {'テスト太郎'}
  let(:email) {'test@example.com'}
  let(:password) {'12345678'}
  let(:user) {User.new(nickname: nickname, email: email, password: password, password_confirmation: password)}

  describe '.first' do
    before do
      create(:user, nickname: nickname, email: email)
    end

    subject { described_class.first }

    it '事前に作成した通りのUserを返す' do
      expect(subject.nickname).to eq('テスト太郎')
      expect(subject.email).to eq('test@example.com')
    end
  end

  describe 'validation' do
    describe 'nickname' do
      describe '文字数制限の検証' do
        context 'nicknameが20文字以下の場合' do
          let(:nickname) { 'あいうえおかきくけこさしすせそたちつてと' }

          it 'User オブジェクトは有効である' do
            expect(user.valid?).to be(true)
          end

        context 'nicknameが20文字を超える場合' do
          let(:nickname) { 'あいうえおかきくけこさしすせそたちつてとな' }

          it 'User オブジェクトは有効である' do
            user.valid?

            expect(user.valid?).to be(false)
            expect(user.errors[:nickname]).to include('is too long (maximum is 20 characters)')
          end
        end
        end
      end
    end
  end
end
