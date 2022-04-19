class Group < ApplicationRecord
  has_one_attached :icon
  belongs_to :user
  validates :name, presence: true, length: {maximum: 50}
  validates :icon, presence: true
  has_many :expenses, foreign_key: :author_id, through :categories
end
