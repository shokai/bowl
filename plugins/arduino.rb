require 'arduino_firmata'

@arduino = ArduinoFirmata.connect

meta :description => "Arduino Firmata Plugin. using http://shokai.github.com/arduino_firmata",
     :author      => "Sho Hashimoto <hashimoto@shokai.org>"

data do
  field "code", :type => String, :default => 'digital_write(13, true)'
end

set :callback, true

call do
  callback arduino.instance_eval code
end
