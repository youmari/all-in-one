class Group < ApplicationRecord
  has_one_attached :icon
  belongs_to :user
  validates :name, presence: true, length: { maximum: 50 }
  validates :icon, presence: true
  has_many :categories, dependent: :destroy
  has_many :expenses, through: :categories, dependent: :destroy

  scope :total, ->(group) { group.expenses.includes(:groups).sum(:amount) }
  # Ex:- scope :active, -> {where(:active => true)}
end
