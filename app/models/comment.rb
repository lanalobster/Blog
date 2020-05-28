class Comment < ApplicationRecord
  belongs_to :article
  validates :commenter, presence: true,
    length: { minimum: 3, maximum: 30 }
  validates :body, presence: true,
  length: { minimum: 3, maximum: 500 }
end
