require 'rails_helper'

RSpec.feature 'Managing comments' do
  scenario 'List all comments' do
    @article = Article.create!(title: 'One Stupid Trick', body: "You won't believe what they did next...")
    @article.comments.create!(body: 'Monday')
    @article.comments.create!(body: 'Tuesday')
    @article.comments.create!(body: 'Wednesday')

    visit '/articles/1/comments'

    expect(page).to have_content 'Comments'
    expect(page).to have_selector 'comment', count: 3
  end

end
