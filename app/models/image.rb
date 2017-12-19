class Image < ApplicationRecord
    has_many :imageLabels
    has_many :labels, through: :imageLabels
    attr_accessor :score # used to assign relevancy score during a label search
end
