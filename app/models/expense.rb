class Expense < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :groups
  validates :name, presence: true, length: {maximum: 50}
  validates :amount, presence: true, comparison: { greater_than_or_equal_to: 0 }
end
