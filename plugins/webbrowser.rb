
data do
  field "url", :type => String
end

on :call do |data, session_id|
  puts cmd = "open #{data['url']}"
  system cmd
end
