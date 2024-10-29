local fast_queue_particles = CreateConVar( 'fast_queue_particles', 1, fast.FCVAR_PRECACHE, nil, 0, 1 )

if ( not fast_queue_particles:GetBool() ) then
	return
end

if ( not fast.AddParticles ) then
	fast.AddParticles = game.AddParticles
end

if ( not fast.AddParticlesQueue ) then
	fast.AddParticlesQueue = {}
end

function game.AddParticles( particleFileName )
	table.insert( fast.AddParticlesQueue, particleFileName )
end

if ( not fast.PrecacheParticleSystem ) then
	fast.PrecacheParticleSystem = PrecacheParticleSystem
end

if ( not fast.PrecacheParticleSystemQueue ) then
	fast.PrecacheParticleSystemQueue = {}
end

function PrecacheParticleSystem( particleSystemName )
	table.insert( fast.PrecacheParticleSystemQueue, particleSystemName )
end
