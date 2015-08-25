function RV = parallel_wrapper( objective_function, XV, varargin )
    n = size( XV, 2 );
    RV = zeros( 1, n );
    parfor i = 1 : n
        R = [];
        WarningState = warning( 'off', 'all' );
        try
            R = objective_function( XV( :, i ), varargin{:} ); %#ok<PFBNS>
        catch
        end
        warning( WarningState );
        if isempty( R ) || ~isfinite( R( 1 ) )
            R = 1e12;
        end
        RV( i ) = R( 1 );
    end
end
