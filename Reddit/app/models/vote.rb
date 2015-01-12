class Vote < ActiveRecord::Base
  validates :user_id, :value, :voteable_id, :voteable_type, presence: true
  validates :value, inclusion:  { in: [-1, 1] }

  belongs_to :voteable, polymorphic: true
end
