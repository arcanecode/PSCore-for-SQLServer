Set-Location .\Demo

# Imports the following columns: "City", "StateShort", "StateFull", "County", "CityAlias"
$cityData = Import-Csv -Path .\us_city_states.csv 

$insertStatement = @'
INSERT INTO dbo.City 
  (City, StateShort, StateFull, County, CityAlias)
VALUES

'@

$sqlOutput = ''
$count = 0
foreach($cityRow in $cityData)
{
  # First Row skip the comma at the start
  if ($count -lt 1)
  {

  }
}