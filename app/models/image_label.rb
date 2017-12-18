class ImageLabel < ApplicationRecord
    belongs_to :label
    belongs_to :image
end
