class Book < ApplicationRecord
        has_many :users, through: :user_books
        has_many :user_books
        validates :title, presence: true
end
