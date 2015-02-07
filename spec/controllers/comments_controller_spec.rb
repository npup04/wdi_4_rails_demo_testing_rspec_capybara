require 'rails_helper'

RSpec.describe CommentsController do
  let(:valid_comment_attribs) {
    { body: 'This is the body of a comment' }
  }
  let(:invalid_comment_attribs) {
    { body: nil }
  }
  let(:valid_article_attribs) {
    { title: 'One Stupid Trick', body: "You won't believe what happens next..." }
  }
  let(:invalid_article_attribs) {
    { title: nil, body: nil }
  }
  let(:article) {
     Article.create!(valid_article_attribs)
  }

  before(:all) do
    Comment.destroy_all
    Article.destroy_all
  end

  describe 'GET index' do
    it 'has a 200 status code' do
      get :index, article_id: article
      expect(response.status).to eq 200
    end

    it 'renders the index template' do
      get :index, article_id: article
      expect(response).to render_template('index')
    end

    it 'assigns @comments' do
      comments = Comment.all
      get :index, article_id: article
      expect(assigns(:comments)).to eq comments
    end
  end # 'GET index'

  describe 'GET new' do
    it 'has a 200 status code' do
      get :new, article_id: article
      expect(response.status).to eq 200
    end

    it 'renders the new template' do
      get :new, article_id: article
      expect(response).to render_template('new')
    end

    it 'assigns @comment' do
      get :new, article_id: article
      expect(assigns(:comment)).to be_a_new Comment
    end
  end # 'GET new'

  describe 'GET show' do
    context 'with show body' do
      let(:comment) {
        article.comments.create!(body: 'Hey Now!')
      }

      it 'has a 200 status code' do
        get :show, article_id: article, id: comment
        expect(response.status).to eq 200
      end

      it 'renders the show template' do
        get :show, article_id: article, id: comment
        expect(response).to render_template('show')
      end

      it 'assigns @comment' do
          get :show, article_id: article, id: comment
          expect(assigns(:comment)).to eq comment
      end
    end # context
  end # 'GET show'

  describe 'POST create' do
    context 'with valid attributes' do
      it 'saves a new comment' do
        expect {
          post :create, comment: valid_comment_attribs, article_id: article
        }.to change(Comment, :count).by 1
      end

      it 'assigns @comment' do
        post :create, comment: valid_comment_attribs, article_id: article
        expect(assigns(:comment)).to be_an Comment
        expect(assigns(:comment)).to be_persisted
      end

      it 'redirects to the created comment' do
        post :create, comment: valid_comment_attribs, article_id: article
        expect(response).to redirect_to(article_comments_path(article))
      end
    end # context

    context 'with invalid attributes' do
      it 'assigns @comment, but does not save a new comment' do
        post :create, comment: invalid_comment_attribs, article_id: article
        expect(assigns(:comment)).to be_a Comment
      end

      it 're-renders the new template' do
        post :create, comment: invalid_comment_attribs, article_id: article
        expect(response).to render_template 'new'
      end
    end # context
  end # 'POST create'

  describe 'GET edit' do
    context 'with show body' do
      let(:comment) {
        article.comments.create!(body: 'New Zealand. Why not?')
      }

      it 'has a 200 status code' do
        get :edit, article_id: article, id: comment
        expect(response.status).to eq 200
      end

      it 'renders the edit template' do
        get :edit,  article_id: article, id: comment
        expect(response).to render_template('edit')
      end

      it 'assigns @comment' do
        get :edit,  article_id: article, id: comment
        expect(assigns(:comment)).to eq comment
      end
    end # context
  end # 'GET edit'

  describe 'PATCH update' do
    context 'with valid attributes' do
      let(:new_comment_valid_attribs) {
        { body: 'Much disbelief!' }
      }

        it 'updates the requested article' do
          comment = Comment.create!(valid_comment_attribs)
          article.comments << comment
          patch :update, article_id: article, id: comment, comment: new_comment_valid_attribs
          comment.reload
          expect(comment.body).to eq new_comment_valid_attribs[:body]
        end

        it 'assigns @article' do
          comment = Comment.create!(valid_comment_attribs)
          article.comments << comment
          patch :update, article_id: article, id: comment, comment: new_comment_valid_attribs
          expect(assigns(:comment)).to eq comment
        end

        it 'redirects to the comment' do
          comment = Comment.create!(valid_comment_attribs)
          article.comments << comment
          patch :update, article_id: article, id: comment, comment: new_comment_valid_attribs
          expect(response).to redirect_to(article_comments_path(article))
        end
    end #context

    context 'with invalid attributes' do
      it 'assigns @comment' do
        comment = Comment.create!(valid_comment_attribs)
        article.comments << comment
        patch :update, article_id: article, id: comment, comment: invalid_comment_attribs
        expect(assigns(:comment)).to eq comment
      end

      it 're-renders the edit template' do
        comment = Comment.create!(valid_comment_attribs)
        article.comments << comment
        patch :update, article_id: article, id: comment, comment: invalid_comment_attribs
        expect(response).to render_template('edit')
      end
    end # context
  end # 'PATCH update'

  describe 'DELETE destroy' do
    it 'destroys the requested comment' do
      comment = Comment.create!(valid_comment_attribs)
      article.comments << comment
      expect {
        delete :destroy, article_id: article, id: comment
      }.to change(Comment, :count).by(-1)
    end

    it 'redirects to the comments list' do
      comment = Comment.create!(valid_comment_attribs)
      article.comments << comment
      delete :destroy, article_id: article, id: comment
      expect(response).to redirect_to article_comments_path
    end

  end # describe 'DELETE destroy'


end

