require 'rails_helper'

RSpec.describe 'posts', type: :request do
  describe 'GET #index' do
    before { get '/users/5/posts' }

    it 'returns a successful response' do
      expect(response).to have_http_status(:success)
    end

    it 'renders the index template' do
      expect(response).to render_template(:index)
    end

    it 'the body returns a correct placeholder' do
      expect(response.body).to include('Here is a list of posts for a given user')
    end
  end

  describe 'GET #show' do
    before { get '/users/5/posts/2' }

    it 'returns a successful response' do
      expect(response).to have_http_status(:success)
    end

    it 'renders the show template' do
      expect(response).to render_template(:show)
    end

    it 'body return right placeholder' do
      expect(response.body).to include('Here are the details of this post')
    end
  end
end
