local fast_queue_sounds = CreateConVar( 'fast_queue_sounds', 1, fast.FCVAR_PRECACHE, nil, 0, 1 )

if ( not fast_queue_sounds:GetBool() ) then
	return
end

if ( not fast.AddSound ) then
	fast.AddSound = sound.Add
end

if ( not fast.AddSoundQueue ) then
	fast.AddSoundQueue = {}
end

function sound.Add( soundData )
	table.insert( fast.AddSoundQueue, soundData )
end

if ( not fast.AddSoundOverrides ) then
	fast.AddSoundOverrides = sound.AddSoundOverrides
end

if ( not fast.AddSoundOverridesQueue ) then
	fast.AddSoundOverridesQueue = {}
end

function sound.AddSoundOverrides( filePath )
	table.insert( fast.AddSoundOverridesQueue, filePath )
end

if ( not fast.PrecacheSound ) then
	fast.PrecacheSound = util.PrecacheSound
end

if ( not fast.PrecacheSoundQueue ) then
	fast.PrecacheSoundQueue = {}
end

function util.PrecacheSound( soundName )
	table.insert( fast.PrecacheSoundQueue, soundName )
end
