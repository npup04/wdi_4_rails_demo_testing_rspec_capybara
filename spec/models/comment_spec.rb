require 'rails_helper'

RSpec.describe Comment do
  describe '.create' do
    it 'creates a new comment' do
      @article = Article.create()
      expect(@article.comments.create()).to be_a Comment
    end

  end
end
