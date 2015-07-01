require 'sinatra/base'
require 'sinatra/contrib'
require 'json'
require 'mongo'
require 'securerandom'
require 'date'

# Rice application
class App < Sinatra::Base
  configure do
    conn = Mongo::MongoClient.new('localhost', 27017)
    set :mongo_connection, conn
    set :mongo_db, conn.db('rice')
  end

  helpers do
    def get_object_id(val)
      BSON::ObjectId.from_string(val)
    end

    def get_document_by_id(id)
      id = get_object_id(id) if id.class == String
      settings.mongo_db['cook']
        .find_one(_id: id)
    end
  end

  post '/api/v1/image' do
    uuid = SecureRandom.uuid
    save_path = "./public/images/#{uuid}.jpg"
    File.open(save_path, 'wb') do |f|
      f.write params[:image][:tempfile].read
    end
    { url: "http://xn--38j8bv87v8z2b18b.com/images/#{uuid}.jpg" }.to_json
  end

  post '/api/v1/cook' do
    params = JSON.parse(request.body.read)
    puts params
    new_id = settings.mongo_db['cook'].insert(params)
    get_document_by_id(new_id).to_json
  end

  get '/api/v1/timeline' do
    settings.mongo_db['cook'].find.to_a.reverse.to_json
  end

  get '/api/v1/cook/:id' do
    get_document_by_id(params[:id]).to_json
  end

  get '/' do
    'You can cook "最高のご飯" !!'
  end
end

run App.run!
