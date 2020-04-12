require 'rails_helper'

describe Post do
  describe '#create' do

    context "登録できない場合" do

      it "appointed_dayがないと登録できないこと" do
        post = build(:post, appointed_day: "")
        post.valid?
        expect(post.errors[:appointed_day]).to include("が入力されていません。")
      end
      
      it "user_idがないと登録できないこと" do
        post = build(:post, user_id: "")
        post.valid?
        expect(post.errors[:user]).to include("ログインしてください")
      end

      it "outfit_idがないと登録できないこと" do
        post = build(:post, outfit_id: "")
        post.valid?
        expect(post.errors[:outfit]).to include("画像を選択してください")
      end

      it "同じuser_idとappointed_dayの組み合わせが1つしか登録できないこと" do
        post = create(:post, appointed_day: "2020-04-01")
        post = build(:post, user_id: post.user_id, appointed_day: "2020-04-01")
        post.valid?
        expect(post.errors[:appointed_day]).to include("は既に使用されています。")

      end

    end

    context "登録できる場合" do

      it "user_id,outfit_id,appointed_dayがあれば登録できること" do
        post = build(:post)
        expect(post).to be_valid
      end

    end
  end

end