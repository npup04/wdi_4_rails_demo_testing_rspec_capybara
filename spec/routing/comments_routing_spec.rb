require 'rails_helper'

RSpec.describe 'routes for comments' do
  it 'routes GET /articles/:article_id/commments to the comments controller' do
    expect(get('/articles/1/comments')).to route_to('comments#index', article_id: '1')
  end

  it 'routes GET /articles/:article_id/comments/new to the comments controller' do
    expect(get('/articles/1/comments/new')).to route_to('comments#new', article_id: '1')
  end

  it 'routes POST /articles/:article_id/comments to the comments controller' do
    expect(post('/articles/1/comments')).to route_to('comments#create', article_id: '1')
  end

  it 'routes GET /articles/:article_id/comments/:id to the comments controller' do
    expect(get('/articles/1/comments/2')).to route_to(
      controller: 'comments',
      action: 'show',
      article_id: '1',
      id: '2'
      )
  end

  it 'routes GET /articles/:article_id/comments/:id/edit' do
    expect(get('/articles/1/comments/2/edit')).to route_to(
      controller: 'comments',
      action: 'edit',
      article_id: '1',
      id: '2'
      )
  end

  it 'routes PATCH /articles/:article_id/comments/:id' do
    expect(patch('/articles/1/comments/2')).to route_to(
      controller: 'comments',
      action: 'update',
      article_id: '1',
      id: '2'
      )
  end

  it 'routes' do
    expect(delete('/articles/1/comments/2')).to route_to(
      controller: 'comments',
      action: 'destroy',
      article_id: '1',
      id: '2'
      )
  end


end
