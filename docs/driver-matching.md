# Driver Matching

## Algorithm
1. Retrieve user's coordinates.
2. Use Redis GEO commands to find nearby available drivers within a radius (e.g., 5km).
3. Filter by vehicle type requested.
4. Sort by distance, rating, and acceptance rate.
5. Dispatch push notification to top N drivers.

## Redis GEO
- `GEOADD drivers_location <lon> <lat> <driver_id>`
- `GEORADIUS drivers_location <lon> <lat> 5 km`

## Criteria
- **Distance**: Closest first.
- **Vehicle Type**: Must match requested type (e.g., 3-wheeler, truck).
- **Availability**: Must be in `AVAILABLE` state.
- **Rating**: Higher rated drivers get slight priority.

## Timeout and Fallback
If no driver accepts within 60 seconds, the radius is expanded or the request is failed with "No drivers available".
