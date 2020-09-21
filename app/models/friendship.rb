class Friendship < ApplicationRecord
  belongs_to :friend, :class_name => "Member"
end
