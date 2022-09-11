# location: spec/feature/integration_spec.rb
require 'rails_helper'

RSpec.describe 'Creating a book', type: :feature do
  scenario 'valid inputs' do
    visit new_book_path
    fill_in 'Title', with: 'harry potter'
    fill_in 'Price', with: "14.99"
    fill_in 'Published', with: "January 15 2001"
    click_on 'Create Book'
    expect(flash[:notice]).to be_present
    visit books_path
    expect(page).to have_content('harry potter')
    expect(page).to have_content('14.99')
    expect(page).to have_content('January 15 2001')
  end
end

RSpec.describe 'Updating a book', type: :feature do
  scenario 'valid inputs' do
    visit new_book_path
    fill_in 'Title', with: 'harry potter'
    fill_in 'Price', with: "14.99"
    fill_in 'Published', with: "January 15 2001"
    click_on 'Create Book'
    expect(flash[:notice]).to be_present
    visit books_path
    expect(page).to have_content('harry potter')
    
    click_on 'Update'
    fill_in 'Title', with:'Harry Potter The Goblet of Fire'
    fill_in 'Price', with:'27.96'
    fill_in 'Published', with:'January 1 2000'
    click_on 'Update Book'
    expect(flash[:notice]).to be_present
    visit books_path
    expect(page).to have_content('Harry Potter The Goblet of Fire')
    expect(page).to have_content('27.96')
    expect(page).to have_content('January 1 2000')

    expect(page).to have_no_content('January 15 2001')
    expect(page).to have_no_content('14.99')

  end
end

Rspec.describe 'Deleting a book', type: :feature do
  scenario 'valid inputs' do
    visit new_book_path
    fill_in 'Title', with:'Harry Potter The Goblet of Fire'
    fill_in 'Price', with:'27.96'
    fill_in 'Published', with:'January 1 2000'
    click_on 'Create Book'
    expect(flash[:notice]).to be_present
    visit books_path
    expect(page).to have_content('Harry Potter The Goblet of Fire')


    click_on 'Delete'
    expect(page).to have_content('Are you sure you want to permanently delete this subject?')
    click_on 'Delete Book'
    expect(flash[:notice]).to be_present
    expect(page).to have_no_content('Harry Potter The Goblet of Fire')
  end
end

Rspec.describe 'Showing a book', type: :feature do
  scenario 'valid inputs' do
    visit new_book_path
    fill_in 'Title', with:'Harry Potter The Goblet of Fire'
    fill_in 'Price', with:'27.96'
    fill_in 'Published', with:'January 1 2000'
    click_on 'Create Book'
    expect(flash[:notice]).to be_present
    visit books_path
    expect(page).to have_content('Harry Potter The Goblet of Fire')

    click_on 'Show Book'
    expect(page).to have_content('Harry Potter The Goblet of Fire')
    expect(page).to have_content('27.96')
    expect(page).to have_content('January 1 2000')
  end
end