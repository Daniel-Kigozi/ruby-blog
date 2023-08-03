require 'rails_helper'

describe User, type: :request do
  describe 'routes with user_controller' do
    it 'should render the index action correctly' do
      get '/users'
      expect(response).to have_http_status(:success)
      expect(response.status).to eq(200)
      expect(response).to render_template('users/index')
      expect(response.body).to include('Find the list of users')
    end

    it 'should render the show action correctly' do
      get '/users/1'
      expect(response).to have_http_status(:success)
      expect(response.status).to eq(200)
      expect(response).to render_template('users/show')
      expect(response.body).to include('Find user details')
    end
  end
end
