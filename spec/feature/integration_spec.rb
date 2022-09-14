# location: spec/feature/integration_spec.rb
require 'rails_helper'

RSpec.describe 'Creating a book', type: :feature do
  scenario 'valid inputs' do
    visit new_book_path
    fill_in 'Title', with: 'harry potter'
    fill_in 'Price', with: "14.99"
    #fill_in 'Published_date', with: "2001-15-01"
    select('15', :from => 'book_published_date_3i')
    select('January', :from => 'book_published_date_2i')
    select('2001', :from => 'book_published_date_1i')
    fill_in 'Author', with: "J. K. Rowling"
    click_on 'Create Book'
    #expect(flash[:notice]).to be_present
    visit books_path
    expect(page).to have_content('harry potter')
    expect(page).to have_content('14.99')
    expect(page).to have_content('2001-01-15')
  end

  scenario 'invalid inputs' do
    visit new_book_path
    fill_in 'Title', with: ''
    fill_in 'Price', with: ""
    #select('15', :from => 'book_published_date_3i')
    #select('January', :from => 'book_published_date_2i')
    #select('2001', :from => 'book_published_date_1i')
    fill_in 'Author', with: ""
    click_on 'Create Book'
    #expect(flash[:notice]).to be_present
    #visit books_path
    expect(page).to have_content("Title can't be blank")
    
    fill_in 'Title', with: 'Harry Potter'
    click_on 'Create Book'
    expect(page).to have_content("Price can't be blank")

    fill_in 'Price', with: '14.99'
    click_on 'Create Book'
    expect(page).to have_content("Date can't be blank")
  end
end

RSpec.describe 'Updating a book', type: :feature do
  scenario 'valid inputs' do
    harryp =  Book.create!(title: 'Harrpy Potter The Chamber of Secrets', price: '14.99', published_date: '2000-01-15', author: 'J. K. Rowling')
    visit edit_book_path(id: harryp.id)
    fill_in 'Title', with:'Harry Potter The Goblet of Fire'
    fill_in 'Price', with:'27.96'
    select('1', :from => 'book_published_date_3i')
    select('January', :from => 'book_published_date_2i')
    select('2000', :from => 'book_published_date_1i')
    fill_in 'Author', with: "J. K. Rowling"
    click_on 'Update Book'
    #expect(flash[:notice]).to be_present
    visit books_path
    expect(page).to have_content('Harry Potter The Goblet of Fire')
    expect(page).to have_content('27.96')
    expect(page).to have_content('2000-01-01')

    expect(page).not_to have_content('2000-15-01')
    expect(page).not_to have_content('14.99')

  end

  scenario 'invalid inputs' do
      harryp = Book.create!(title: 'Harrpy Potter The Chamber of Secrets', price: '14.99', published_date: '2003-16-01', author: 'J. K. Rowling')
      visit edit_book_path(id: harryp.id)
      fill_in 'Title', with: ''
      fill_in 'Price', with: ""
      #find_field('Published date').set('01/01/2000')
      click_on 'Update Book'
      expect(page).to have_content("Title can't be blank")
      
      fill_in 'Title', with: 'Harry Potter'
      click_on 'Update Book'
      expect(page).to have_content("Price can't be blank")
      #expect(page).to have_content("Date can't be blank")
    end
end

RSpec.describe 'Deleting a book', type: :feature do
  scenario 'valid inputs' do
    harryp = Book.create!(title: 'Harry Potter The Chamber of Secrets', price: '14.99', published_date: '2003-01-16', author: 'J. K. Rowling')
    visit books_path
    expect(page).to have_content('Harry Potter The Chamber of Secrets')

    click_on 'Delete'
    #page.driver.browser.switch_to.alert.accept
    visit books_path
    #accept_alert
    expect(page).not_to have_content('Harry Potter The Chamber of Secrets')
  end
end

RSpec.describe 'Showing a book', type: :feature do
  scenario 'valid inputs' do
    harryp = Book.create!(title: 'Harry Potter The Chamber of Secrets', price: '27.96', published_date: '2000-01-01', author: 'J. K. Rowling')
    visit books_path
    expect(page).to have_content('Harry Potter The Chamber of Secrets')

    click_on 'Show'
    expect(page).to have_content('Harry Potter The Chamber of Secrets')
    expect(page).to have_content('27.96')
    expect(page).to have_content('2000-01-01')
  end
end