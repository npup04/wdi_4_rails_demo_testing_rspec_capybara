require 'rails_helper'

RSpec.feature 'Managing comments' do
  scenario 'List all comments' do
    @article = Article.create!(title: 'One Stupid Trick', body: "You won't believe what they did next...")
    Comment.create!(body: 'body content 1', article: @article)
    Comment.create!(body: 'body content 2', article: @article)
    Comment.create!(body: 'body content 3', article: @article)

    visit article_comments_path(@article)

    expect(page).to have_content 'Comments'
    expect(page).to have_selector 'p', count: 3
  end # scenario 'List all comments'

  scenario 'Create a comment' do
    @article = Article.create!(title: 'One Stupid Trick', body: "You won't believe what they did next...")

    visit new_article_comment_path(@article)

    fill_in 'Body', with: "Umm yeah."

    click_on 'Create Comment'
    expect(page).to have_content(/success/i)
    expect(page).to have_content "Umm yeah."
  end

  scenario 'Read a comment' do
    @article = Article.create!(title: 'One Stupid Trick', body: "You won't believe what they did next...")
    @comment= Comment.create!(body: "I heart cheese!", article: @article)

    visit article_comment_path(@article, @comment)

    expect(page.find('h1')).to have_content "I heart cheese!"
  end

  scenario 'Update a comment' do
    @article = Article.create!(title: 'One Stupid Trick', body: "You won't believe what they did next...")
    @comment= Comment.create!(body: "This smells amaaazing.", article: @article)

    visit edit_article_comment_path(@article, @comment)

    expect(page).to have_content 'This smells amaaazing.'

    fill_in 'Body', with: 'Much disbelief!!!'

    click_on 'Update Comment'
    expect(page).to have_content(/success/i)
    expect(page).to have_content 'Much disbelief!!!'
  end

  scenario 'Delete a comment' do
    @article = Article.create!(title: 'One Stupid Trick', body: "You won't believe what they did next...")
    @comment= Comment.create!(body:"It's snowing cats and dogs!", article: @article)

    visit edit_article_comment_path(@article, @comment)

    expect(page).to have_content "It's snowing cats and dogs!"

    click_on 'Delete Comment'
    expect(page).to have_content(/success/i)
  end
end
