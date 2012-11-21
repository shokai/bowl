require 'arduino_firmata'

@arduino = ArduinoFirmata.connect

meta :description => "Arduino Plugin. receive data with fishbowl.io.on(\"plugin_arduino\", callback)",
     :author      => "Sho Hashimoto <hashimoto@shokai.org>"

data do
  field "command", :type => String, :default => 'digital_write(13, true)'
end

set :callback, true

call do
  callback arduino.instance_eval command
end
