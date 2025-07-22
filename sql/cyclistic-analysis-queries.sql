-- 1. Compare trip volume by user type and ride type
SELECT rideable_type , member_casual, COUNT(*) AS total_user_type /*selects & counts 2 tables*/
FROM cyclistic-project-464519.trip_data.cyclistic_trips
GROUP BY member_casual, rideable_type    /*groups 2 tables*/
ORDER BY total_user_type DESC; /*(optional, sorts most used combination at the top)*/

-- 2. Compare ride duration
SELECT member_casual, ROUND(AVG(ride_length), 0) AS avg_ride_length /*selects 2 tables, find avg of ride len & round it*/
FROM cyclistic-project-464519.trip_data.cyclistic_trips
GROUP BY member_casual; /*group by user type*/

-- 3. Usage by day of the week
SELECT member_casual, /*selects user type*/
    EXTRACT(DAYOFWEEK FROM started_at) AS weekday, /*selects start datetime stamp & extracts day of week, table alias weekday*/
    COUNT(*) AS trip_count /*counts rows & names table trip_count*/
FROM cyclistic-project-464519.trip_data.cyclistic_trips
GROUP BY weekday, member_casual /*grouped by weekday(numeric) & user type*/
ORDER BY weekday; /*numerically ordered by weekday; 1-Sun, 2-Mon, 3-Tues, etc*/

-- 4. Time of day patterns
SELECT member_casual, /*selects user type*/
    EXTRACT(HOUR FROM started_at) AS hour_of_day, /*selects start datetime stamp & extracts hour, table alias hour of the day*/
    COUNT(*) AS trip_count /*counts all rows and names table trip_count*/
FROM cyclistic-project-464519.trip_data.cyclistic_trips
GROUP BY hour_of_day, member_casual /*grouped by hour of the day & user type*/
ORDER BY hour_of_day; /*sorted by hour of the day*/

-- 5. Most common start stations
SELECT start_station_name, /*select start station name*/
      COUNT(*) AS start_count /*counts rows & table alias - start_count*/
FROM cyclistic-project-464519.trip_data.cyclistic_trips
WHERE start_station_name IS NOT NULL /*checks & avoids null values*/
GROUP BY start_station_name /*grouped by start station name*/
ORDER BY start_count DESC /*sorted by most common start station*/
LIMIT 10;

-- 6. Ride type preferences
SELECT rideable_type, COUNT(*) ride_count /*selects ride type & counts all rows, table named ride_count*/
FROM cyclistic-project-464519.trip_data.cyclistic_trips
GROUP BY rideable_type; /*grouped by ride type*/


