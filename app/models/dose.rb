class Dose < ApplicationRecord
  belongs_to :ingredients
  belongs_to :cocktails
  validates_uniqueness_of :cocktail_id, scope: :ingredient_id

  validates :description, presence: true
end
