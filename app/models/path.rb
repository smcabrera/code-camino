class Path < ActiveRecord::Base
  belongs_to :user
  has_many :tutorials
end
