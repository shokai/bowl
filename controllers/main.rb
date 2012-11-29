before '/*.json' do
  content_type 'application/json'
end

before '/*' do
  @title = 'FishBowl'
end

get '/' do
  haml :index
end

get '/plugins' do
  @title = "Plug-ins"
  haml :plugins
end

get '/plugin/:name' do
  name = params['name']
  halt 404, "plugin \"#{name}\" not found" unless plugins.has_key? name
  @plugin = plugins[name]
  @title = "plugin/#{name}"
  halt 500, "Error : #{@plugin.message} at #{Plugin.list[name]}" if @plugin.kind_of? Error
  haml :plugin
end
