require 'rails_helper'

feature 'user', type: :feature do
  let(:user) { create(:user) }

  scenario '非ログイン時の表示' do
    visit root_path
    expect(page).to have_no_content('Closet')
  end

  scenario '新規登録機能' do
    expect {
      visit root_path
      fill_in 'user_email', with: 'goutfit_t_user@gmail.com'
      fill_in 'user_password', with: 'goutfit_t_user'
      fill_in 'user_password_confirmation', with: 'goutfit_t_user'
      find('input[value="Sign up"]').click
      expect(current_path).to eq root_path
    }.to change(User, :count).by(1)
  end

  scenario 'ログイン機能' do
    visit root_path
    fill_in 'login_email', with: user.email
    fill_in 'login_password', with: user.password
    find('input[value="Login"]').click
    expect(current_path).to eq root_path
    expect(page).to have_content('Closet')
  end

  scenario 'ログアウト機能' do
    visit root_path
    fill_in 'login_email', with: user.email
    fill_in 'login_password', with: user.password
    find('input[value="Login"]').click
    expect(current_path).to eq root_path
    expect(page).to have_content('Closet')
    click_link('sign_out_link')
    expect(current_path).to eq root_path
    expect(page).to have_no_content('Closet')
  end
end