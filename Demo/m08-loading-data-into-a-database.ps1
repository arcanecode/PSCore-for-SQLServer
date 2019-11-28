<#-----------------------------------------------------------------------------
  PowerShell Core for SQL Server
  Creating a Database

  Author: Robert C. Cain | @ArcaneCode | arcanecode@gmail.com
          http://arcanecode.com
 
  This module is Copyright (c) 2018, 2019 Robert C. Cain. All rights reserved.

  The code herein is for demonstration purposes. No warranty or guarentee
  is implied or expressly granted. 
  
  This module may not be reproduced in whole or in part without the express
  written consent of the author. Portions may be be used within your own
  projects.
-----------------------------------------------------------------------------#>

# Import our module, and setup a hash table with our values
# so we can use splatting
Import-Module SqlServer   

$sqlParams = @{ 'ServerInstance' = 'localhost,1433'
                'Database' = 'master'
                'Username' = 'sa'
                'Password' = 'passW0rd!'
                'QueryTimeout' = 50000
              }

# There are multiple methods to load data
$sql = @"
  USE MyCoolDatabase
  GO

  INSERT INTO dbo.City 
    (City, StateShort, StateFull, County, CityAlias)
  VALUES
    ('Holtsville', 'NY', 'New York', 'SUFFOLK', 'Internal Revenue Service')
"@
Invoke-SqlCmd -Query $sql @sqlParams 

$sql = 'SELECT * FROM MyCoolDatabase.dbo.City'
Invoke-SqlCmd -Query $sql @sqlParams 

# You could also compose and insert using variables
# Note we can use any names for the variables, but using the same name as
# the column will make it easier to keep track of
$city = 'Holtsville'
$stateShort = 'NY'
$stateFull = 'New York'
$county = 'SUFFOLK'
$cityAlias = 'Holtsville'

$sql = @"
  USE MyCoolDatabase
  GO

  INSERT INTO dbo.City 
    (City, StateShort, StateFull, County, CityAlias)
  VALUES
    ('$city', '$stateShort', '$stateFull', '$county', '$cityAlias')
"@
Invoke-SqlCmd -Query $sql @sqlParams 

$sql = 'SELECT * FROM MyCoolDatabase.dbo.City'
Invoke-SqlCmd -Query $sql @sqlParams | Format-Table



