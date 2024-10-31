class Comment < ApplicationRecord
  include Visible

  belongs_to :index
end
