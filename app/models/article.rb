class Article < ApplicationRecord
    has_many :comments, dependent: :destroy
    validates :title, presence: true,
    length: { minimum: 3, maximum: 30 }
    validates :text, presence: true,
    length: { minimum: 3, maximum: 1000 }
    belongs_to :user
    validates :user_id, presence: true
    accepts_nested_attributes_for :comments
end
