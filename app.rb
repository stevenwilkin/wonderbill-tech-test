require 'sinatra'
require 'securerandom'
require 'mini_magick'

class App < Sinatra::Base
  helpers do
    def image_dir
      ENV.fetch('IMAGE_DIR', File.join(__dir__, 'images'))
    end
  end

  post '/' do
    image = params[:image]

    halt 400 unless image
    halt 400 unless image[:tempfile]

    id = SecureRandom.uuid
    extension = image[:filename].match(/.*\.(.*)$/)[1]
    path = File.join(image_dir, "#{id}.#{extension}")
    File.open(path, 'w') { |f| f.write image[:tempfile].read }

    body id
  end

  get '/:id.?:format?' do
    matching_files = Dir[File.join(image_dir, "#{params[:id]}.*")]

    halt 404 unless matching_files.count == 1

    image_path = matching_files.first

    if params[:format]
      image = MiniMagick::Image.open(image_path)
      image.format(params[:format])
      send_file image.path
    else
      send_file image_path
    end
  end
end
