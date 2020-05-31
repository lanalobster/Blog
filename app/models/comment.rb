class Comment < ApplicationRecord
  belongs_to :article
  validates :body, presence: true,
  length: { minimum: 3, maximum: 500 }
  belongs_to :user
  validates :user_id, presence: true
end
