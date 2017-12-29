class Api::V1::SearchController < ApplicationController
    def show
        # singularizes and downcases search term
        search_term = params["term"].singularize.downcase

        # returns all images with given label
        images = Label.find_by(name: search_term).images
        
        # writes relevancyScore for each image
        images.map do |image|
            image.score = image.imageLabels.find_by(image_id: image.id).relevancyScore
        end

        render json: images, methods: [:score]
    end
end