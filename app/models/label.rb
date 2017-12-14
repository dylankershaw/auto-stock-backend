class Label < ApplicationRecord
    has_many :imageLabels
    has_many :images, through: :imageLabels
end
