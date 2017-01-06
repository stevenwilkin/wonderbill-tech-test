# Back End Developer Interview Challenge

You are a senior member of a team that has been tasked with developing a programmatic image storage and processing service called ProgImage.com. 

Unlike other image storage services that have a web front-end and target end-users, ProgImage is designed as a specialised image storage and processing engine to be used by other applications, and will (only) provide high-performance programmatic access via its API. 

Apart from bulk image storage and retrieval, ProgImage provides a number of image processing and transformation capabilities such as compression, rotation, a variety of filters, thumbnail creation, and masking. 

These capabilities are all delivered as a set of high-performance web-services that can operate on images provided as data in a request, operate on a remote image via a URL, or on images that are already in the repository. All of the processing features should be able to operate in bulk, and at significant scale.

* Build a simple microservice that can receive an uploaded image and return a unique identifier for the uploaded image that can be used subsequently to retrieve the image.
* Extend the microservice so that different image formats can be returned by using a different image file type as an extension on the image request URL. 
* Write a series of automated tests that test the image upload, download and file format conversion capabilities. 

# Prerequisites

* [Bundler]
* [Ruby 2.3.1][Ruby]
* [ImageMagick]

# Installation

```sh
$ bundle
```

# Usage

## Running tests

```sh
$ rspec
```

## Running application

```sh
$ rackup
```

## Example

```sh
$ id=$(curl -sF image=@spec/fixtures/logo.gif -X POST 0.0.0.0:9292)
$ curl -sI 0.0.0.0:9292/$id | grep image
Content-Type: image/gif
$ curl -sI 0.0.0.0:9292/$id.png | grep image
Content-Type: image/png
```

[bundler]: http://bundler.io
[ruby]: http://www.ruby-lang.org/en
[imagemagick]: https://www.imagemagick.org/script/index.php
