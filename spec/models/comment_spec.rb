require 'rails_helper'

RSpec.describe Comment do
  let(:valid_article_attribs) {
    { title: 'One Stupid Trick', body: "You won't believe what happens next..." }
  }
  let(:article) {
     Article.create!(valid_article_attribs)
  }

  before(:all) do
    Comment.destroy_all
    Article.destroy_all
  end

  describe '.create' do
    it 'creates a new comment' do
      expect(article.comments.create()).to be_a Comment
    end

    it 'is valid with valid body content' do
      expect(article.comments.create(body: 'Amaaaazing body content')).to be_valid
    end

    it 'is invalid without a body field' do
      expect(article.comments.create()).not_to be_valid
    end

    it 'is invalid with a nil body' do
      expect(article.comments.create(body: nil)).not_to be_valid
    end

  end # describe
end
