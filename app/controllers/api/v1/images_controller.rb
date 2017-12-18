
require "google/cloud/storage"
require 'base64'

class Api::V1::ImagesController < ApplicationController
    def show
        image = Image.find(params[:id])
        render json: user
    end

    def create

        # extracts file information
        uploaded_io = params["image_io"]["base64"]
        metadata = uploaded_io.split(',/')[0] + ","
        filetype = metadata.split("/")[1].split("base64")[0][0...-1]
        base64_string = uploaded_io[metadata.size..-1]
        filename = "#{Time.new.to_i}.#{filetype}"
        
        # converts from base64 string to image file
        blob = Base64.decode64(base64_string)
        image = MiniMagick::Image.read(blob)
        
        # initializes google cloud storage session
        storage = Google::Cloud::Storage.new(
            project_id: ENV['GOOGLE_CLOUD_PROJECT'],
            credentials: JSON.parse(File.read('config/google_cloud_credentials.json'))
            #### NEED TO MAKE THIS REFERENCE AN ENV VAR; WON'T WORK ON HEROKU
        )
        
        # initializes google cloud storage bucket and uploads image
        bucket_name = "auto-stock-189103.appspot.com"
        bucket = storage.bucket bucket_name
        bucket.create_file image.tempfile.path, filename

        # assigns public permission to file
        file = bucket.file filename
        file.acl.public!

        new_image = Image.new
        new_image.url = "https://storage.googleapis.com/#{bucket_name}/#{filename}"
        byebug
        # labels = (send to google vision for labels)
        # labels.each do |label|
            # new_label = Label.find_or_create
            # new_image.labels << new_label
            # end
        # new_image.save
        # user = User.find(params["userId"])
        # user.images << new_image
        # user.save
        # render json: new_image
    end
end