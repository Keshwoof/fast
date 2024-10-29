AddCSLuaFile 'cl_init.lua'
AddCSLuaFile 'shared.lua'
include 'shared.lua'

AddCSLuaFile 'precache/particles.lua'
include 'precache/particles.lua'
AddCSLuaFile 'precache/models.lua'
include 'precache/models.lua'
AddCSLuaFile 'precache/sounds.lua'
include 'precache/sounds.lua'

AddCSLuaFile 'coroutine.lua'
include 'coroutine.lua'

MsgC( fast.Color, '[fast]: init.lua\n' )
