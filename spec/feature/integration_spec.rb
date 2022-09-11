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

  scenario 'invalid inputs' do
    visit new_book_path
    fill_in 'Title', with: ''
    fill_in 'Price', with: ""
    fill_in 'Published', with: ""
    click_on 'Create Book'
    expect(flash[:notice]).to be_present
    visit books_path
    expect(page).to have_content("Title can't be blank")
    expect(page).to have_content("Price can't be blank")
    expect(page).to have_content("Date can't be blank")
  end
end

RSpec.describe 'Updating a book', type: :feature do
  scenario 'valid inputs' do
    harryp = Book.create!(title: 'Harrpy Potter The Chamber of Secrets', price: '14.99', published: 'January 16 2003')
    visit edit_city_path(id: harryp.id)
    fill_in 'Title', with:'Harry Potter The Goblet of Fire'
    fill_in 'Price', with:'27.96'
    fill_in 'Published', with:'January 1 2000'
    click_on 'Update Book'
    expect(flash[:notice]).to be_present
    visit books_path
    expect(page).to have_content('Harry Potter The Goblet of Fire')
    expect(page).to have_content('27.96')
    expect(page).to have_content('January 1 2000')

    expect(page).not_to have_content('January 15 2001')
    expect(page).not_to have_content('14.99')

  end

  scenario 'invalid inputs' do
      harryp = Book.create!(title: 'Harrpy Potter The Chamber of Secrets', price: '14.99', published: 'January 16 2003')
      visit edit_book_path(id: harryp.id)
      fill_in 'Title', with: ''
      fill_in 'Price', with: ""
      fill_in 'Published', with: ""
      click_on 'Update Book'
      expect(page).to have_content("Title can't be blank")
      expect(page).to have_content("Price can't be blank")
      expect(page).to have_content("Date can't be blank")
    end
end

Rspec.describe 'Deleting a book', type: :feature do
  scenario 'valid inputs' do
    harryp = Book.create!(title: 'Harry Potter The Goblet of Fire', price: '14.99', published: 'January 16 2003')
    visit books_path
    expect(page).to have_content('Harry Potter The Goblet of Fire')


    click_on 'Delete'
    expect(page).to have_content('Are you sure you want to permanently delete this subject?')
    click_on 'Delete Book'
    accept_alert
    expect(page).not_to have_content('Harry Potter The Goblet of Fire')
  end
end

Rspec.describe 'Showing a book', type: :feature do
  scenario 'valid inputs' do
    harryp = Book.create!(title: 'Harry Potter The Goblet of Fire', price: '14.99', published: 'January 16 2003')
    visit books_path
    expect(page).to have_content('Harry Potter The Goblet of Fire')

    click_on 'Show Book'
    expect(page).to have_content('Harry Potter The Goblet of Fire')
    expect(page).to have_content('27.96')
    expect(page).to have_content('January 1 2000')
  end
end