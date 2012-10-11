-- Add the following code to prepare for Live Coding.
--
if not(initialized) then
	-- Our demo requires physics
	require("box2d")
	
	-- Ask to connect to the ZBS debugging server running on desktop machine
	-- at a particular IP address. Use your computer's address or hostname.
	--
	--require("mobdebug").start("192.168.1.101")
	
	-- A constant event servicing loop is necessary to gve the ZBS debugger something to interrupt
	stage:addEventListener(Event.ENTER_FRAME, function() end)
	
	-- Create a restart required button
	RestartRequired=BhButton.new("Images/RestartButtonOff", "Images/RestartButtonOn")
	RestartRequired.isToggle=true
	RestartRequired:setScale(0.5)
	RestartRequired:setPosition(50, 50)
	stage:addChild(RestartRequired)

	initialized=true
end

function Application:reset()
	-- Helper method to clear the contents of the stage (except for our restart button)
	RestartRequired:removeFromParent()
	while stage:getNumChildren()>0 do
		stage:removeChildAt(1)
	end
	stage:addChild(RestartRequired)
	collectgarbage("collect")
end

require "Livepad"