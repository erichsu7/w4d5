class Post < ActiveRecord::Base
  validates :title, :author_id, presence: true
  validates :title, uniqueness: true

  belongs_to :author,
    class_name: 'User'

  has_one :moderator,
    through: :sub

  has_many :post_subs, inverse_of: :post, dependent: :destroy

  has_many :subs,
    through: :post_subs

  has_many :comments
end
