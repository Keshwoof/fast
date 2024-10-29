local fast_queue_models = CreateConVar( 'fast_queue_models', 1, fast.FCVAR_PRECACHE, nil, 0, 1 )

if ( not fast_queue_models:GetBool() ) then
	return
end

if ( not fast.PrecacheModel ) then
	fast.PrecacheModel = util.PrecacheModel
end

if ( not fast.PrecacheModelQueue ) then
	fast.PrecacheModelQueue = {}
end

function util.PrecacheModel( modelName )
	table.insert( fast.PrecacheModelQueue, modelName )
end
