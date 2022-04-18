class Group < ApplicationRecord
  belongs_to :user
  validates :name, presence: true, length: {maximum: 50}
  validates :icon, presence: true,
  
  
  has_many :expenses
end
