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

  scenario 'Outfit投稿機能' do
    expect {
      click_link('outfit_link')
      expect(current_path).to eq outfits_path
      attach_file 'outfit_image', 'spec/fixtures/test_img.jpg'
      find('input[value="コーデを登録"]').click
    }.to change(Outfit, :count).by(1)
  end

  scenario 'Outfit削除機能' do
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