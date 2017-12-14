class ImageLabel < ApplicationRecord
    belongs_to :image
    belongs_to :label
end
