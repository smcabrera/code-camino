class Lesson < ActiveRecord::Base
  belongs_to :user
  belongs_to :path
end
