require "antigate_api"
require "debugger"

client = AntigateApi::Client.new( "f5a7805db844a4a9784517d715ef0f41", {debug: true})
captcha_id, captcha_answer = client.decode("captcha.gif")
puts captcha_id + " " + captcha_answer

