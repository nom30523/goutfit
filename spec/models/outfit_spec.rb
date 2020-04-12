require 'rails_helper'

describe Outfit do
  describe '#create' do

    context "登録できない場合" do

      it "imageがない場合は登録できないこと" do
        outfit = build(:outfit, image: "")
        outfit.valid?
        expect(outfit.errors[:image]).to include("が入力されていません。")
      end

      it "user_idがない場合は登録できないこと" do
        outfit = build(:outfit, user_id: nil)
        outfit.valid?
        expect(outfit.errors[:user]).to include("ログインしてください")
      end

    end

    context "登録できる場合" do

      it "imageとuser_idがある場合は登録できること" do
        outfit = build(:outfit)
        expect(outfit).to be_valid
      end

    end

  end
end