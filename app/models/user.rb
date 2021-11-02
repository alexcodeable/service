class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, 
         :confirmable, :lockable, :timeoutable, :trackable, 
         :omniauthable, authentication_keys: [:login]

          def self.from_omniauth(auth)
            where( provider: auth.provider, uid: auth.uid).first_or_create do |user|
              user.email = auth.info.email
              user.password = Devise.friendly_token[0, 20]
              user.name = auth.info.name
              # user.image = auth.info.image

              user.skip_confirmation!
            end
          end
  


        #  validates :username, presence: true, uniqueness: { case_sensitive: false }


         attr_writer :login
       
         def login
           @login || self.username || self.email
         end
         def self.find_for_database_authentication(warden_conditions)
           conditions = warden_conditions.dup
           if login = conditions.delete(:login)
             where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
           elsif conditions.has_key?(:username) || conditions.has_key?(:email)
             where(conditions.to_h).first
           end
         end
end
