require "box2d"

function rgb(r, g, b)
	return ((r*256)+g)*256+b
end

Mechanism = Mechanism or Core.class(Sprite)

function  Mechanism:onEnterFrame()
	self.world:update()
	
	local canvas=self.canvas
	canvas:clear()
	canvas:beginPath()
	canvas:setLineStyle(20, 0xB63E41)
	canvas:moveTo(self.zero:getPosition())
	canvas:lineTo(self.gideros:getPosition())
	canvas:endPath()
end

function Mechanism:init()
	local w, h=application:getContentWidth(), application:getContentHeight()
	self.world=b2.World.new(0, 10.0, true)
	b2.setScale(400)
		
	--local edge=self.world:createTerrain(nil, {	0, 0, w, 0, w, h, 0, h, 0, 0 })
	
	self.canvas=Shape.new()
	self:addChild(self.canvas)
	
	local zero=Bitmap.new("Images/ZeroBrane.png")
	zero:setScale(0.6)
	self.world:createRectangle(zero, {type="static"})
	zero:setAnchorPoint(0.50, 0.29)
	zero:setPosition(0, 475)
	self:addChild(zero)
	self.zero=zero 
	
	local  gideros=Bitmap.new("Images/Gideros.png")
	local length=400
	gideros:setScale(0.32)
	self.world:createCircle(gideros, {type="dynamic", draggable=true})
	gideros:setPosition(0, zero:getY()+length)
	self:addChild(gideros)
	self.gideros=gideros
	
	local gx, gy=gideros:getPosition()
	local zx, zy=zero:getPosition()
	local  jdef=b2.createDistanceJointDef(gideros.body, zero.body, gx, gy, zx, zy )
	self.world:createJoint(jdef)
	
	local bowerhaus = Bitmap.new("Images/Bowerhaus.png")
	bowerhaus:setPosition(w/2, 965)
	self.world:createRectangle(bowerhaus, {type="static", isSensor=true})
	self:addChild(bowerhaus) 
	self.bowerhaus=bowerhaus
	
	self.world:addBeginContact(gideros, bowerhaus, 
		function()
			bowerhaus:setAlpha(0.2)
			GTween.new(bowerhaus, 0.5, {alpha=1})
			local event=Event.new("tick")
			self:dispatchEvent(event)
		end)
	
	stage:addChild(self)
	stage:addEventListener(Event.ENTER_FRAME, function(...) pcall(self.onEnterFrame, ...) end, self)
	
	GTween.new(zero, 3, {x=w/2})
end



	


