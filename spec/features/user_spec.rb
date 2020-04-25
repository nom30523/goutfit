require 'rails_helper'

feature 'user', type: :feature do
  let(:user) { create(:user) }

  context 'ログインしていない場合' do
    scenario 'Closetボタンが存在しないこと' do
      visit root_path
      expect(page).to have_no_content('Closet')
    end
  end

  context 'ログインしている場合' do
    background do
      visit root_path
      fill_in 'login_email', with: user.email
      fill_in 'login_password', with: user.password
      find('input[value="Login"]').click
      expect(current_path).to eq root_path
    end

    scenario 'Closetボタンが存在すること' do
      visit root_path
      expect(page).to have_content('Closet')
    end
  end
end