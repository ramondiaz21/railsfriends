# class Friend < ApplicationRecord
# end

class Friend < ApplicationRecord
  belongs_to :user
end