require 'rack/test'

require_relative '../app'

RSpec.describe App do
  include Rack::Test::Methods

  def app
    described_class.new
  end

  describe 'GET /' do
    before do
      get '/'
    end

    specify { expect(last_response).to be_ok  }
  end
end
