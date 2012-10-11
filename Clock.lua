require "Mechanism"
require "Face"

Clock = Clock or Core.class(Sprite)

function Clock:init()
	local w, h=application:getContentWidth(), application:getContentHeight()
	local mech=Mechanism.new()
	local face=Face.new()
	face:setScale(0.5)
	face:setPosition(w/2, 195)
	
	mech:addEventListener("tick", function() face:tick(1) end)
end


application:setBackgroundColor(0)

Clock.new()