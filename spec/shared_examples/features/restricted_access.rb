require 'rails_helper'

shared_examples 'Restricted access' do
  let(:alice) { create(:user) }

  scenario "user can't create object" do
    sign_in alice
    visit obj_path

    expect(page).to have_content 'You are not authorized to access this page.'
  end

  scenario "guest can't create object" do
    visit obj_path

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end
