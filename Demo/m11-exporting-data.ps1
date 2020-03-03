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


# Retrieve the data
$sql = 'SELECT * FROM MyCoolDatabase.dbo.City'
$data = Invoke-SqlCmd -Query $sql @sqlParams 

# Once we have the data we can export it to a variety of formats

# Export as a list
$data | Out-File './Demo/CityDataList.txt'

# Export as a table
$data | Format-Table | Out-File './Demo/CityDataTable.txt'

# Export to a CSV file
$data | Export-Csv './Demo/CityData.csv'

# Export as XML
$data | ConvertTo-Xml -As String | Out-File './Demo/CityData.xml'

# Export to JSON
$data | ConvertTo-Json | Out-File './Demo/CityData.json'

