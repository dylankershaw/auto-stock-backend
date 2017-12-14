class Image < ApplicationRecord
    has_many :imageLabels
    has_many :labels, through: :imageLabels
end
