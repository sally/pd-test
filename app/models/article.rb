class Article < ApplicationRecord
  belongs_to :author, class_name: :user
  has_many :footnotes
  has_many :photos
  has_many :bibliographies
  has_many :article_categories
  has_many :revisions
  has_many :categories, through: :article_categories
  has_many :editors, through: :revisions, source: :user
end
