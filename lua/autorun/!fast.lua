AddCSLuaFile()

if ( SERVER ) then

	include 'fast/init.lua'

elseif ( CLIENT ) then

	include 'fast/cl_init.lua'

end
