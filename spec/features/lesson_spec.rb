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

    it "should see all the lessons for a particular path" do
      path = create(:path, :user => @alice)
      lesson = create(:lesson, :user => @alice, :path => path)

      visit path_lessons_path(path)

      expect(page).to have_content("Test Lesson")
      expect(page).to have_content("www.example.com/lesson")
    end

    xit "should be able to create a new lesson for one of her paths" do
      path = create(:path, :user => @alice)
      visit path_path(path)
      click_link "Add Lesson"

      fill_in "lesson[name]", with: "New Lesson"
      fill_in "lesson[link]", with: "www.example.com/lesson"
      click_button "Save"

      expect(@alice.paths.first.lessons.count).to eq(1)
    end

    xit "should be able to delete lessons for paths she created" do
      path = create(:path, :user => @alice)
      lesson = create(:lesson, :user => @alice, :path => path)

      visit path_path(path)
      click_link "Destroy"

      expect(@alice.paths.first.lessons.count).to eq(0)
    end

    xit "should be able to edit lessons on paths she created" do
      path = create(:path, :user => @alice)
      lesson = create(:lesson, :user => @alice, :path => path )

      visit path_path(path)
      click_link "Edit"
      fill_in "path[name]", with: "Edited"
      click_button "Save"

      expect(Lesson.first.name).to eq("Edited")
    end

    xit "should NOT be able to edit lessons on paths created by someone else" do
      bobs_path = create(:path, :user => @bob)

      visit paths_path

      expect(page).to_not have_content("Edit")
    end

    xit "should NOT be able to delete edit lessons on paths created by someone else" do
      bobs_path = create(:path, :user => @bob)

      visit paths_path

      expect(page).to_not have_content("Destroy")
    end

    # TODO: Eventually I'd like to show users all the paths that they're working on
  end
end

