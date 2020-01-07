class Dose < ApplicationRecord
  belongs_to :ingredient
  belongs_to :cocktail
  validates_uniqueness_of :cocktail_id, scope: :ingredient_id

  validates :description, presence: true
end
