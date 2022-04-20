require 'rails_helper'

RSpec.describe 'group Index', type: :feature do
  describe 'User' do
    before(:each) do
      picture = 'https://images.unsplash.com/photo-1508921912186-1d1a45ebb3c1?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80'
      @user1 = User.create(name:'lolo',email: 'test@gmail.com',password: 1234567, password_confirmation:1234567)
      @group = Group.create()
      visit 'users/sign_in'
      fill_in 'Email', with: 'test@gmail.com'
      fill_in 'Password', with: 1234567
      click_on 'Log In'
    end

    it 'shows the categories page' do
      expect(page).to have_content('CATEGORIES')
      expect(page).to have_content('NEW CATEGORY')
    end

    it 'create a new category but an error happened' do
      click_on 'NEW CATEGORY'
      click_on 'Create Group'
      expect(page).to have_content('2 errors prohibited this group from being saved')
      expect(page).to have_content("Name can't be blank")
      expect(page).to have_content("Icon can't be blank")
    end

    it 'create new category' do
      click_on 'NEW CATEGORY'
      fill_in "Name",	with: "clothes" 
      page.attach_file('group[icon]',Rails.root + 'spec/features/search.png')
      click_on 'Create Group'
      expect(page).to have_content("Group was successfully created.")
      expect(page).to have_content("clothes")
    end
    describe "Test group transactions (Expenses)" do
      before(:each) do 
        click_on 'NEW CATEGORY'
        fill_in "Name",	with: "clothes" 
        page.attach_file('group[icon]',Rails.root + 'spec/features/search.png')
        click_on 'Create Group'
      end

      it "can see the total of transaction" do
        expect(page).to have_content("$0.0")
      end

      it "click on category it should take you to category page " do
        click_on 'clothes'
        expect(page).to have_content("ADD EXPENSE")
      end

      it "create a new expense" do
        click_on 'clothes'
        click_on 'ADD EXPENSE'
        fill_in "Name", with: 'jeans'
        fill_in "Amount", with: 500.5
        select "clothes", from: "expense[group_id]"
        click_on 'Create Expense'
        expect(page).to have_content("Expense was successfully created.")
        expect(page).to have_content("jeans")
        expect(page).to have_content("$500.5")
      end
    end
  end
end
