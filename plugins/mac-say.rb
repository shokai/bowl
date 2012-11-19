
data do
  field "speech", :type => String, :default => 'hello'
  field "voice", :type => String, :default => 'kyoko'
end

call do
  puts cmd = "say #{speech} -v #{voice}"
  system cmd
end
