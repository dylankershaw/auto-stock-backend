class Api::V1::SearchController < ApplicationController
    def show
        # singularizes and downcases search term
        search_term = params["term"].singularize.downcase

        # returns all images with given label
        images = Label.find_by(name: search_term).images
        
        # writes relevancyScore for each image
        images.map do |image|
            label = Label.find_by(name: params["search"]["term"])
            image.score = image.imageLabels.find_by(label_id: label.id).relevancyScore
        end

        render json: images, methods: [:score]
    end
end