local function IterateQueue( identifier, queue, wait, iterations, func )

	while ( true ) do

		if ( not next( queue ) ) then

			coroutine.yield( 'dead' )
			return 'dead'

		else

			coroutine.wait( wait )

			for index = 1, iterations do

				local value = table.remove( queue, index )

				if ( value ) then
					func( value )
				end

			end

		end

	end

	return 'ok'
end

function fast:CreateCoroutine( identifier, queue, wait, iterations, func )
	return coroutine.create( function()
		IterateQueue( identifier, queue, wait, iterations, func )
	end )
end

function fast:RunCoroutine( thread )

	if ( not thread ) then
		return false
	end

	if ( coroutine.status( thread ) == 'dead' ) then
		return false
	end

	local ok, message = coroutine.resume( thread )

	if ( ok == false ) then
		thread = nil
		error( message )
	end

	return true
end
