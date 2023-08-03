require 'rails_helper'

describe Post, type: :request do
  describe 'routes with post_controller' do
    it 'should render the index action correctly' do
      get '/users/:user_id/posts'
      expect(response).to have_http_status(:success)
      expect(response.status).to eq(200)
      expect(response).to render_template('posts/index')
      expect(response.body).to include('Here is a list of posts for a given user')
    end

    it 'should render the show action correctly' do
      get '/posts/:id'
      expect(response).to have_http_status(:success)
      expect(response.status).to eq(200)
      expect(response).to render_template('posts/show')
      expect(response.body).to include('Post details')
    end
  end
end
