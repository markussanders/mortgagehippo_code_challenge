class Coin < ApplicationRecord
    validates :name, presence: true
    validates :value, presence: true, numericality: { only_integer: true }
end
