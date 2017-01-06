require 'sinatra'
require 'securerandom'

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

  get '/:id' do
    matching_files = Dir[File.join(image_dir, "#{params[:id]}.*")]

    halt 404 unless matching_files.count == 1

    send_file matching_files.first
  end
end
