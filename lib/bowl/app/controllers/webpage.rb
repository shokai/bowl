
CometIO.on :webpage do |data|
  cmd = "open '#{data['url']}'"
  system cmd
  # CometIO.push :webpage, data
end

get '/webpage' do
  haml :webpage
end

get '/webpage/control' do
  haml :webpage_control
end
