class User < ApplicationRecord
    has_many :coins
    
    before_validation :assign_api_key, :on => :create
    
    validates :name, presence: true
    validates :api_key, presence: true
    validates :email, presence: true, if: Proc.new { |user| user.is_admin }
    
    def generate_api_key
        loop do
            token = SecureRandom.base64.tr('+/=', 'Qrt')
            break token unless User.exists?(api_key: token)
        end
    end

    def assign_api_key 
        self.api_key = self.generate_api_key
    end
end
