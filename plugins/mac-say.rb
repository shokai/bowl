
data do
  field "speech", :type => String
  field "voice", :type => String
end

on :call do |data, session_id|
  puts cmd = "say #{data['speech']} -v #{data['voice']}"
  system cmd
end
