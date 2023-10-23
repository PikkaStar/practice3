class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         has_many :books,dependent: :destroy
         has_many :book_comments,dependent: :destroy
         has_many :favorites,dependent: :destroy
         
         has_many :relationships,foreign_key: "followed_id",dependent: :destroy
         has_many :reverse_of_relationships,class_name: 'Relationship',foreign_key: 'follower_id',dependent: :destroy
         
         has_many :followings,through: :relationships,source: :follower
         has_many :follower,through: :reverse_of_relationships,source: :following
         
         has_one_attached :profile_image
         validates :name,uniqueness: true,length: {in: 2..20}
         validates :introduction,length: {maximum: 200}

         def get_profile_image(width,height)
           if profile_image.attached?
             profile_image.variant(resize_to_limit: [width, height]).processed
           else
             'no_image'
           end

         end

end
