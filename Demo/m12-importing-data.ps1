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

#------------------------------------------------------------------------------
# Import our module, and setup a hash table with our values
# so we can use splatting
#------------------------------------------------------------------------------
Import-Module SqlServer   

$sqlParams = @{ 'ServerInstance' = 'localhost,1433'
                'Database' = 'master'
                'Username' = 'sa'
                'Password' = 'passW0rd!'
                'QueryTimeout' = 50000
              }

function Reset-Table ()
{  
  $sql = 'TRUNCATE TABLE MyCoolDatabase.dbo.City'
  Invoke-SqlCmd -Query $sql @sqlParams
      
}

$data = Import-Csv './Demo/CityData.csv'
$data | Select-Object -First 10 | Format-Table



