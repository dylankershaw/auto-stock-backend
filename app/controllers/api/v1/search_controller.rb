class Api::V1::SearchController < ApplicationController
    def show
        # returns all images with given label
        images = Label.find_by(name: params["term"].downcase).images
        
        # writes relevancyScore for each image
        images.map do |image|
            image.score = image.imageLabels.find_by(image_id: image.id).relevancyScore
        end

        render json: images, methods: [:score]
    end
end