require 'spec_helper'
require 'rails_helper'

describe 'User' do

  include Warden::Test::Helpers
  Warden.test_mode!

  before do
    @user = create(:user)
  end

  context 'signs in' do

    before do
      login_as(@user, :scope => :user)
    end

    fit 'is redirected to their dashboard' do
      visit root_path

      expect(page).to_not have_content("Sign up")
      expect(page).to have_content("Listing paths")
    end
  end
end
