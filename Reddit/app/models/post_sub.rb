class PostSub < ActiveRecord::Base
  validates :post_id, :sub_id, presence: true
  validates :post_id,
    uniqueness: { scope: :sub_id, message: "cannot be posted more than once in sub"}

  belongs_to :post, inverse_of: :post_subs
  belongs_to :sub
end
