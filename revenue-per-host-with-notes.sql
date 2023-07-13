SELECT host_id,host_name,
    # Because some host has more that 1 accommodation, I want to know the number of accommodations per host
    COUNT(host_name) as number_of_houses,
    
    # Because the price column has the the dollar sign in front of the number making it a string, we replace it
    # We do the same for the comma ',' for number that are in the thousands, then we calculate the revenue in the last 30 days for every host
    SUM(CAST(REPLACE(REPLACE (price, '$', ''),',','') AS UNSIGNED) * (30 - availability_30)) AS proj_rev_30,
    
    # We do the same to calculate the average revenue for every host
    AVG(CAST(REPLACE(REPLACE (price, '$', ''),',','') AS UNSIGNED) * (30 - availability_30)) AS proj_avg_30
    
FROM airbnb.listings
    
# I want to know only for the accommodations that had availability in the last 365 days
WHERE availability_365 > 0

GROUP BY host_id
ORDER BY proj_rev_30 DESC
