if ( not istable( fast ) ) then

	fast = {
		IsValid = function( self )
			return true
		end
	}

end

fast.Color = Color( 100, 220, 100, 200 )

fast.FCVAR_PRECACHE = { FCVAR_ARCHIVE, FCVAR_REPLICATED }

if ( not fast.Threads ) then
	fast.Threads = {}
end

function fast:InitPostEntity()

	-- materials
	-- models
	self.Threads.PrecacheModel = self:CreateCoroutine( 'models', self.PrecacheModelQueue, 1 / 10, 1, self.PrecacheModel )
	-- particles
	self.Threads.AddParticles = self:CreateCoroutine( 'particles', self.AddParticlesQueue, 1 / 30, 5, self.AddParticles )
	self.Threads.PrecacheParticleSystem = self:CreateCoroutine( 'particlesystems', self.PrecacheParticleSystemQueue, 1 / 60, 10, self.PrecacheParticleSystem )
	-- sounds
	self.Threads.AddSound = self:CreateCoroutine( 'addsounds', self.AddSoundQueue, 1 / 60, 100, self.AddSound )
	self.Threads.AddSoundOverrides = self:CreateCoroutine( 'soundscripts', self.AddSoundOverridesQueue, 1 / 60, 10, self.AddSoundOverrides )
	self.Threads.PrecacheSound = self:CreateCoroutine( 'precachesounds', self.PrecacheSoundQueue, 1 / 60, 10, self.PrecacheSound )

end
hook.Add( 'InitPostEntity', fast, fast.InitPostEntity )

function fast:Think()

	if ( self:RunCoroutine( self.Threads.PrecacheModel ) ) then
		return
	end

	if ( not self:HandleParticles() ) then
		return
	end

	self:HandleSounds()

end
hook.Add( 'Think', fast, fast.Think )

function fast:HandleSounds()

	-- soundscripts first, otherwise we have nothing to precache!
	if ( ( self:RunCoroutine( self.Threads.AddSound ) )
	or ( self:RunCoroutine( self.Threads.AddSoundOverrides ) ) ) then
		return
	end

	self:RunCoroutine( self.Threads.PrecacheSound )

end

fast.AddParticlesFinish = false
fast.PrecacheParticleSystemFinish = false
function fast:HandleParticles()

	if ( self:RunCoroutine( self.Threads.AddParticles ) ) then

	else

		self.AddParticlesFinish = true

	end

	if ( ( self.AddParticlesFinish ) and ( self:RunCoroutine( self.Threads.PrecacheParticleSystem ) ) ) then

	else

		self.PrecacheParticleSystemFinish = true

	end

	return ( ( self.AddParticlesFinish ) and ( self.PrecacheParticleSystemFinish ) )
end

if ( CLIENT ) then
	MsgC( fast.Color, '[fast]: shared.lua\n' )
end
