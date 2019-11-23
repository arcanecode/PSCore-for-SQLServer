function Format-ForSqlInsert ($data)
{
  if ($data -eq $null )
  {
    $retVal = "NULL"
  }
  else
  {
    $retVal = $data.Replace("'", "''")
    $retVal = "'$($retVal)'"
  }
  return $retVal
}


$loc = '/home/arcanecode/code/PSCore-for-SQLServer/Demo'
Set-Location $loc
Clear-Host

# Imports the following columns: "City", "StateShort", "StateFull", "County", "CityAlias"
$cityData = Import-Csv -Path .\us_city_states.csv 

# Create the header for each INSERT statement
$insertStatement = @'
INSERT INTO dbo.City 
  (City, StateShort, StateFull, County, CityAlias)
VALUES
'@

# Create a new string builder to hold the entire output
$sqlOutput = [System.Text.StringBuilder]::new()
$sqlOutput.AppendLine($insertStatement)

# Sent a counter, every 1000 rows we'll close the insert and start new one
$count = 0
$totalCount = 0

# Loop over each row
foreach($cityRow in $cityData)
{
  # Pull the data from the row and format it for a SQL insert
  $city = Format-ForSqlInsert $cityRow.City
  $stateShort = Format-ForSqlInsert $cityRow.StateShort
  $stateFull = Format-ForSqlInsert $cityRow.StateFull
  $county = Format-ForSqlInsert $cityRow.County
  $cityAlias = Format-ForSqlInsert $cityRow.CityAlias

  # First Row skip the comma at the start
  if ($count -lt 1)
  {
    $row = "  ($city, $stateShort, $stateFull, $county, $cityAlias)"
  }
  else 
  {
    $row = ", ($city, $stateShort, $stateFull, $county, $cityAlias)"  
  }

  [void]$sqlOutput.AppendLine( $row )
  $count++
  $totalCount++

  # If we reach 1000 insert statements
  if ($count -ge 1000)
  {
    [void]$sqlOutput.AppendLine( ";" )
    [void]$sqlOutput.AppendLine( 'GO' )
    [void]$sqlOutput.AppendLine( '' )
    [void]$sqlOutput.AppendLine( $insertStatement )
    $count = 0
    Write-Host "Total Count: $totalCount"
  }

}

[void]$sqlOutput.AppendLine( ";" )
[void]$sqlOutput.AppendLine( 'GO' )
[void]$sqlOutput.AppendLine( '' )

Write-Host "Total Count: $totalCount"
$sqlOutput | Set-Content -Path 'insert-city-data.sql' 

