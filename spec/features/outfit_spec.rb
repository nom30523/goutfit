require 'rails_helper'

feature 'outfit', type: :feature do
  let(:user) { create(:user) }

  background do
    visit root_path
    fill_in 'login_email', with: user.email
    fill_in 'login_password', with: user.password
    find('input[value="Login"]').click
    expect(current_path).to eq root_path
  end
  
  scenario 'Outfit投稿画面に遷移し、投稿が可能であること' do
    expect {
      click_link('outfit_link')
      expect(current_path).to eq outfits_path
      attach_file 'outfit_image', 'spec/fixtures/test_img.jpg'
      find('input[value="コーデを登録"]').click
    }.to change(Outfit, :count).by(1)
  end

  scenario '削除ボタンを押すことで、投稿を削除できる' do
    click_link('outfit_link')
    expect(current_path).to eq outfits_path
    attach_file 'outfit_image', 'spec/fixtures/test_img.jpg'
    find('input[value="コーデを登録"]').click
    expect(current_path).to eq outfits_path
    expect {
      click_link('削除')
    }.to change(Outfit, :count).by(-1)
  end
end