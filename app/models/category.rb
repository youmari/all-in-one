class Category < ApplicationRecord
  belongs_to :expense
  belongs_to :group
end
