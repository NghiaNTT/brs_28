class UserBook < ActiveRecord::Base
  belongs_to :user
  belongs_to :book

  scope :favorite, -> (user){
    where(user_id: user.id, is_favorite: true)
  }

  scope :reading, -> (user){
    where(user_id: user.id, status: 0)
  }
end
