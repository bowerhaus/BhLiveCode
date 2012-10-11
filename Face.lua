Face = Face or Core.class(Sprite)

local TICKTIME= 0.5

function Face:moveHands()
	GTween.new(self.hour, TICKTIME, {rotation=self.secs/3600*360/12+180})
	GTween.new(self.min, TICKTIME, {rotation=math.floor(self.secs/60)*360/60+180})
	GTween.new(self.sec, TICKTIME, {rotation=self.secs*360/60+180})
end

function Face:setTime(hh, mm, ss)
	self.secs=(hh*60+mm)*60+ss
	self:moveHands()
end

function Face:setCurrentTime()
	local timetab=os.date("*t")
	self:setTime(timetab.hour, timetab.min, timetab.sec)
end

function Face:tick(inc)
	self.secs=self.secs+(inc or 1)
	self:moveHands()	
end	

function Face:init()
	local face=Bitmap.new("Images/ClockFace.png")
	face:setAnchorPoint(0.5, 0.5)
	self:addChild(face)
	
	-- Hour hand
	local hour=Bitmap.new("Images/HourHand.png")
	hour:setAnchorPoint(0.6, 0.104)
	hour:setRotation(180)
	self.hour=hour
	self:addChild(hour)
	
	-- Minute hand
	local min=Bitmap.new("Images/MinuteHand.png")
	min:setAnchorPoint(0.6, 0.104)
	min:setRotation(180)
	self.min=min
	self:addChild(min)
	
	-- Second hand
	local sec=Bitmap.new("Images/SecondHand.png")
	sec:setAnchorPoint(0.6, 0.104)
	sec:setRotation(180)
	self.sec=sec
	self:addChild(sec)
	
	-- Center
	local center=Bitmap.new("Images/Center.png")
	center:setAnchorPoint(0.5, 0.5)
	self:addChild(center)

	stage:addChild(self)
	self:setCurrentTime()
end
