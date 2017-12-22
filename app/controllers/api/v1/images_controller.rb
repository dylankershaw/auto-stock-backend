
require "google/cloud/storage"
require "google/cloud/vision"
require 'base64'

class Api::V1::ImagesController < ApplicationController
    def show
        image = Image.find(params[:id])
        render :json => image.to_json(:include => [:labels, :imageLabels, :user])
    end

    def create
        image = {}
        filetype = ""
        path = ""

        if params["image"]["url"]
            # extracts file information for url uploads
            path = open(params["image"]["url"])
            filetype = params["image"]["url"].split(".").last
        else
            # extracts file information for computer uploads
            uploaded_io = params["image_io"]["base64"]
            filetype = uploaded_io.split("/")[1].split("\;")[0]
            metadata = "data:image/" + filetype + "\;base64,"
            base64_string = uploaded_io[metadata.size..-1]
            
            # converts from base64 string to image file
            blob = Base64.decode64(base64_string)
            image = MiniMagick::Image.read(blob)

            path = image.tempfile.path
        end

        
        # initializes google cloud storage session
        storage = Google::Cloud::Storage.new(
            project_id: ENV['GOOGLE_CLOUD_PROJECT'],
            credentials: JSON.parse(File.read('config/google_cloud_credentials.json'))
            )
            
        # initializes google cloud storage bucket and uploads image
        filename = "#{Time.new.to_i}.#{filetype}"
        bucket_name = "auto-stock-189103.appspot.com"
        bucket = storage.bucket bucket_name
        gcs_image = bucket.create_file path, filename

        # assigns public permission to file
        file = bucket.file filename
        file.acl.public!

        # creates image and associates it with user who uploaded it
        new_image = Image.create(url: "https://storage.googleapis.com/#{bucket_name}/#{filename}")
        user = User.find(params["userId"])
        user.images << new_image
        
        # initializes google vision session
        vision = Google::Cloud::Vision.new(
            credentials: JSON.parse(File.read('config/google_cloud_credentials.json'))
        )

        # sends image to google cloud vision for label assignment
        gcv_image = vision.image "gs://#{bucket_name}/#{filename}"

        # associates labels with image
        gcv_image.labels.each do |gcv_label|
            label = Label.find_or_create_by(name: gcv_label.description)
            image_label = ImageLabel.create(
                image_id: new_image.id,
                label_id: label.id,
                relevancyScore: gcv_label.score
            )
        end

        render :json => new_image.to_json(:include => [:labels, :imageLabels, :user])
    end
end
