require 'spec_helper'
require 'rails_helper'

describe "User" do

    include Warden::Test::Helpers
    Warden.test_mode!

    before do
      @alice = create(:user, :name => "Alice")
      @bob = create(:user, :name => "Bob")
    end

  context "Signed in" do

    before do
      login_as(@alice, :scope => :user)
    end

    it "should see all paths from all users" do
      alice_path = create(:path, :user => @alice, :name => "Alice's Path")
      bob_path = create(:path, :user => @bob, :name => "Bob's Path")

      visit paths_path

      expect(page).to have_content("Alice's Path")
      expect(page).to have_content("Bob's Path")
    end

    it "should be able to create a new path" do
      visit paths_path
      click_link "New Path"

      fill_in "path[name]", with: "New Path"
      click_button "Save"

      expect(@alice.paths.count).to eq(1)
    end

    it "should be able to view the details about a path" do
      path = create(:path)

      visit path_path(path)

      # TODO: We haven't added the tutorials yet, but we could make sure it displays all of its tutorials
      expect(page).to have_content("Test Path")
    end

    it "should be able to delete paths that he/she created" do
      alices_path = create(:path, :user => @alice)

      visit paths_path
      click_link "Destroy"

      expect(@alice.paths.count).to eq(0)
    end

    it "should be able to edit paths that he/she created" do
      alices_path = create(:path, :user => @alice)

      visit paths_path
      click_link "Edit"
      fill_in "path[name]", with: "Edited"
      click_button "Save"

      expect(Path.first.name).to eq("Edited")
    end

    it "should NOT be able to edit paths created by someone else" do
      bobs_path = create(:path, :user => @bob)

      visit paths_path

      expect(page).to_not have_content("Edit")
    end

    it "should NOT be able to delete paths created by someone else" do
      bobs_path = create(:path, :user => @bob)

      visit paths_path

      expect(page).to_not have_content("Destroy")
    end

    # TODO: Eventually I'd like to show users all the paths that they're working on
  end
end

