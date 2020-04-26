require 'rails_helper'

feature 'post', type: :feature do
  let(:user) { create(:user) }
  let(:outfit) { create(:outfit, user_id: user.id) }
  let(:outfits) { create_list(:outfit, 2, user_id: user.id) }

  background do
    # ログイン動作
    visit root_path
    fill_in 'login_email', with: user.email
    fill_in 'login_password', with: user.password
    find('input[value="Login"]').click
    expect(current_path).to eq root_path
  end

  scenario 'post投稿機能' do
    outfit_id = outfit.id
    expect {
      click_link('new_post_link')
      expect(current_path).to eq new_post_path
      choose("post_outfit_id_#{outfit_id}")
      expect(page).to have_checked_field("post_outfit_id_#{outfit_id}")
      fill_in 'post_appointed_day', with: '2020/04/01'
      find('input[value="カレンダーへ保存"]').click
      expect(current_path).to eq root_path
    }.to change(Post, :count).by(1)
  end

  scenario 'post編集機能' do
    first_outfit_id = outfits[0].id
    second_outfit_id = outfits[1].id
    # postの投稿
    click_link('new_post_link')
    expect(current_path).to eq new_post_path
    choose("post_outfit_id_#{first_outfit_id}")
    expect(page).to have_checked_field("post_outfit_id_#{first_outfit_id}")
    fill_in 'post_appointed_day', with: '2020/04/01'
    find('input[value="カレンダーへ保存"]').click
    expect(current_path).to eq root_path
    # postの編集
    post = Post.find_by(outfit_id: first_outfit_id)
    click_link("calendar_post_#{post.id}")
    expect(current_path).to eq edit_post_path(post.id)
    expect(page).to have_checked_field("post_outfit_id_#{first_outfit_id}")
    expect(page).to have_field 'post_appointed_day', with: post.appointed_day
    choose("post_outfit_id_#{second_outfit_id}")
    expect(page).to have_checked_field("post_outfit_id_#{second_outfit_id}")
    find('input[value="変更を保存する"]').click
    expect(current_path).to eq root_path
    expect(post.reload.outfit_id).to eq second_outfit_id
  end

  scenario 'post削除機能' do
    # postの投稿
    outfit_id = outfit.id
    click_link('new_post_link')
    expect(current_path).to eq new_post_path
    choose("post_outfit_id_#{outfit_id}")
    expect(page).to have_checked_field("post_outfit_id_#{outfit_id}")
    fill_in 'post_appointed_day', with: '2020/04/01'
    find('input[value="カレンダーへ保存"]').click
    expect(current_path).to eq root_path
    # postの削除
    expect {
      post = Post.find_by(outfit_id: outfit_id)
      click_link("calendar_post_#{post.id}")
      expect(current_path).to eq edit_post_path(post.id)
      expect(page).to have_checked_field("post_outfit_id_#{outfit_id}")
      expect(page).to have_field 'post_appointed_day', with: post.appointed_day
      click_link('登録を削除する')
    }.to change(Post, :count).by(-1)
  end
end