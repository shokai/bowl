
data do
  field "url", :type => String
  field "size", :type => Fixnum
end

on :call do |data, session_id|
  puts cmd = "open #{data['url']}"
  system cmd
end
