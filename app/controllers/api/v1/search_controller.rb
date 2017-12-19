class Api::V1::SearchController < ApplicationController
    def show
        label = Label.find_by(name: params["term"].downcase)
        render json: label.images
    end
end