require 'rails_helper'

RSpec.describe 'Articles API' do
  def article_params
    {
      title: 'One Weird Trick',
      content: 'You won\'t believe what happens next...'
    }
  end

  def articles
    Article.all
  end

  def article
    Article.first
  end

  before(:all) do
    Article.create!(article_params)
  end

  after(:all) do
    Article.delete_all
  end

  describe 'GET /articles' do #
    it 'lists all articles' do # it is a method defined by Rspec - rails
      get '/articles' # get is a method defined by Rspec - rails

      expect(response).to be_success  #'be_success' is a "Matcher" for 200 HTTP response
                                      # returns true if get '/articles' responds with 200

      articles_response = JSON.parse(response.body)
      expect(articles_response.length).to eq(articles.count)
      expect(articles_response['articles'].first['title']).to eq(article.title)
    end
  end

  describe 'GET /articles/:id' do
    it 'shows one article' do
      get "/articles/#{article.id}"

      expect(response).to be_success

      article_response = JSON.parse(response.body)
      expect(article_response['id']).to eq(article.id)
      expect(article_response['title']).to eq(article_params[:title])
    end
  end

  describe 'POST /articles' do
    skip 'creates an article' do
    end
  end

  describe 'PATCH /articles/:id' do
    def article_diff
      { title: 'Two Stupid Tricks' }
    end

    skip 'updates an article' do
    end
  end

  describe 'DELETE /articles/:id' do
    skip 'deletes an article' do
    end
  end
end
