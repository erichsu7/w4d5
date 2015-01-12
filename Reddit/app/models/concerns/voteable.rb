module Voteable
  extend ActiveSupport::Concern

  included do
    has_many :votes, as: :voteable,
    class_name: "Vote",
    dependent: :destroy
  end

  def score
    self.votes.sum(:value)
  end
end
