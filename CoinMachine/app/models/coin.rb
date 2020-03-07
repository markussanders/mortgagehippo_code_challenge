class Coin < ApplicationRecord
    belongs_to :user, optional: true

    validates :name, presence: true
    validates :value, presence: true, numericality: { only_integer: true }


    def self.total_values
        Coin.all.reduce(0) { |total, coin| total + coin.value }
    end
end
