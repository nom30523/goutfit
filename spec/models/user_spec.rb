require 'rails_helper'
describe User do
  describe '#create' do

    context "登録できない場合" do

      it "e-mailがない場合は登録できないこと" do
        user = build(:user, email: "")
        user.valid?
        expect(user.errors[:email]).to include("が入力されていません。")
      end

      it "同じe-mailが存在する場合は登録できないこと" do
        user = create(:user)
        user = build(:user, email: "test@gmail.com")
        user.valid?
        expect(user.errors[:email]).to include("は既に使用されています。")
      end

      it "passwordがない場合は登録できないこと" do
        user = build(:user, password: "")
        user.valid?
        expect(user.errors[:password]).to include("が入力されていません。")
      end
      
      it "passwordがあっても、同じpassword_confirmationがない場合は登録できないこと" do
        user = build(:user, password_confirmation: "111111")
        user.valid?
        expect(user.errors[:password_confirmation]).to include("が内容とあっていません。")
      end

      it "passwordが6文字未満の場合は登録できないこと" do
        user = build(:user, password: "00000")
        user.valid?
        expect(user.errors[:password]).to include("は6文字以上に設定して下さい。")
      end
      
      it "メールアドレスの書式でない場合は登録できないこと" do
        user = build(:user, email: "testgmail.com")
        user.valid?
        expect(user.errors[:email]).to include("は有効でありません。")
      end
    end

    context "登録できる場合" do

      it "passwordが6文字以上の場合は登録できること" do
        user = build(:user, password: "000000")
        expect(user).to be_valid
      end
      
      it "全ての項目が入力されている場合は登録できること" do
        user = build(:user)
        expect(user).to be_valid
      end

    end

  end
end