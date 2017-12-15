class Api::V1::ImagesController < ApplicationController
    def show
        image = Image.find(params[:id])
        render json: user
    end

    def create
        byebug
        url = params["url"]
        image = Image.new
        # image.url = (upload to google cloud)
        # labels = (send to google vision for labels)
        # labels.each do |label|
            # new_label = Label.find_or_create
            # image.labels << new_label
            # end
        # image.save
        user = User.find(params["userId"])
        user.images << image
        # user.save
        # render json: image
    end
end
