require 'rails_helper'

RSpec.describe 'Expenses', type: :request do
  before(:each) do 
    @user = User.create(name: 'lolo', email: 'test@gmail.com', password: 1_234_567, password_confirmation: 1_234_567)
    sign_in @user
  end
  describe 'GET /index' do
    before(:each) { get groups_path }
    it 'should match ok status' do
      expect(response).to have_http_status(:ok)
    end
    it 'should the body has CATEGORIES text' do
      expect(response.body).to include('CATEGORIES')
    end
    it 'should render index template' do
      expect(response).to render_template(:index)
    end
  end
  describe 'GET /show' do
    before(:each) do 
      @group = Group.create(name:'test1',user_id:@user.id)
      @group.icon.attach(io: File.open("./spec/features/search.png"), filename: "search.png", content_type: "image/png")
      @group.save!
      get group_path(@group.id)
    end
    it 'should match ok status' do
      expect(response).to have_http_status(:ok)
    end
    it 'should the body has test1 text' do
      expect(response.body).to include('test1')
    end
     it 'should the body has expense' do
      expect(response.body).to include('Expense')
    end
       it 'should the body has ADD Expense' do
      expect(response.body).to include('ADD EXPENSE')
    end
    it 'should render index template' do
      expect(response).to render_template(:show)
    end
  end
end
