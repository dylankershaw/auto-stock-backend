### [click here for tagless-frontend](https://github.com/dylankershaw/tagless-frontend)

# Tagless
An auto-indexing photo site that assign relevant labels to images on upload. User-submitted images are automatically tagged and indexed by Google Cloud's [Vision API](https://cloud.google.com/vision/).

## Key Technologies, Packages, and Gems
* Front End
	* React
	* Redux
	* react-router
	* semantic-ui-react
	* redux-thunk
	* redux-form
	* Chart.js
* Back End
	* Rails
	* Google Cloud Storage
	* Google Cloud Vision
	* Mini Magick
	* JWT

## Core Features
* Base64 image encoding (front-end) and decoding (back-end)
* Automatic AI-based label assignment of images
* User authentication and cookie storage through JSON Web Tokens (JWT)
	* Logs users in on page load if their localStorage has a valid token
* Automatic backup of every image via Google Cloud Storage
* Users can upload images from their computer or by entering a third-party URL
* Dynamic handling of image downloads allows for multiple file types

## Demo
![placeholder animation](https://media.giphy.com/media/3oFzlWJtpswtKtVo4w/giphy.gif)

Auto-animating placeholder prompts users to enter a search term and background loops through an array of images every five seconds. [See here](https://github.com/dylankershaw/tagless-frontend/blob/master/src/components/search/search_bar.js) and [here](https://github.com/dylankershaw/tagless-frontend/blob/master/src/components/search/inactive_search_container.js) for code.

<br/>

![search from root](https://media.giphy.com/media/3oFzmolvlBML6YqxDq/giphy.gif)

Placeholder animation disables when search bar is clicked. Search returns all images than have been tagged with a specified keyword (e.g. clouds) and sorts them by their relevancy score.

<br />

![url upload](https://media.giphy.com/media/26CaMGy5EBtCgcDMA/giphy.gif)

Images can be uploaded by entering a third-party URL.

<br />

![file upload](https://media.giphy.com/media/l49JYK801LY9uBTJC/giphy.gif)

Or from a user's computer. Images are auto-tagged on upload in a matter of seconds. [See here](https://github.com/dylankershaw/tagless-backend/blob/master/app/controllers/api/v1/images_controller.rb) for back-end image controller (upload code is in the "create" action).

<br />

![results show](https://thumbs.gfycat.com/EachBackAtlanticsharpnosepuffer-size_restricted.gif)

Search results are sorted by relevancy score. (e.g. searching for "clouds" displays images very likely to contain clouds at the top and those less likely to contain clouds toward the bottom)

<br />

![image show](https://media.giphy.com/media/l49JBGmkwB57hdJIs/giphy.gif)

Clicking an image displays all of its labels, sorted by relevancy score. In this example, "dog" appears toward the top with a score of 97% whereas "grass" appears toward the bottom with a score of 53%.

<br />

![radar chart](https://media.giphy.com/media/l49JBsrwzKajoc2ju/giphy.gif)

Labels can be view as bar charts or in a radar chart.

<br />

![tag click](https://media.giphy.com/media/3oFzmngqhpovwC5Cms/giphy.gif)

Clicking a label displays all other images that have been tagged with that keyword.

<br />

![user show](https://media.giphy.com/media/l49JI7zSZPueeqDcI/giphy.gif)

Clicking a username displays all images uploaded by that user.
