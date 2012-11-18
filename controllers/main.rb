before '/*.json' do
  content_type 'application/json'
end

before '/*' do
  @title = 'fishbowl'
end

get '/' do
  haml :index
end

get '/plugin/:name' do
  name = params['name']
  halt 404, "plugin \"#{name}\" not found" unless plugins.has_key? name
  @plugin = plugins[name]
  @title = "#{@title}/plugin/#{name}"
  haml :plugin
end
