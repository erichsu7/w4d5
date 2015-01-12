class Post < ActiveRecord::Base
  include Voteable
  validates :title, :author_id, presence: true
  validates :title, uniqueness: true

  belongs_to :author,
    class_name: 'User',
    foreign_key: :author_id,
    inverse_of: :posts

  has_one :moderator,
    through: :sub

  has_many :post_subs, inverse_of: :post, dependent: :destroy

  has_many :subs,
    through: :post_subs

  has_many :comments

  def comments_by_parent_id
    comments_by_parent_id = Hash.new{ |hash, key| hash[key] = []}

    self.comments.includes(:author).each do |comment|
      comments_by_parent_id[comment.parent_comment_id] << comment
    end

    comments_by_parent_id
  end
end
