require 'rack/test'

require_relative '../app'

RSpec.describe App do
  include Rack::Test::Methods

  def app
    described_class.new
  end

  let(:image_path) { File.join(__dir__, 'fixtures', 'logo.gif') }
  let(:image) { Rack::Test::UploadedFile.new(image_path, 'image/gif') }
  let(:uploads) { ENV['IMAGE_DIR'] }

  before do
    ENV['IMAGE_DIR'] = Dir.mktmpdir
  end

  after do
    ENV.delete('IMAGE_DIR')
  end

  describe 'POST /' do
    context 'when no request params are supplied' do
      before do
        post '/'
      end

      specify { expect(last_response.status).to eq(400)  }
    end

    context 'when an image is not supplied' do
      before do
        post '/', image: 'foo'
      end

      specify { expect(last_response).to_not be_ok  }
    end

    context 'when an image is supplied' do
      let(:returned_id) { last_response.body }
      let(:uploaded_path) { File.join(uploads, "#{returned_id}.gif") }

      before do
        post '/', image: image
      end

      specify { expect(last_response).to be_ok }
      specify { expect(File.exists?(uploaded_path)).to be_truthy }
      specify do
        expect(FileUtils.compare_file(uploaded_path, image_path)).to be_truthy
      end
    end
  end
end
