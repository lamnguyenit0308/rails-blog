class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :validatable,
         :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :posts, foreign_key: "author_id"
end
