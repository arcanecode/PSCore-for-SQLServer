#------------------------------------------------------------------------------
# Cleanup
#------------------------------------------------------------------------------

# When done you may wish to cleanup. First, get a listing to refresh 
# yourself on names and other info
Clear-Host
sudo docker container ls

# The above version only lists running containers. If you want to see all
# containers, running or not, you can use:
sudo docker ps -a 

# Next, stop your SQL Server container, passing in the name from the 
# Names column
sudo docker stop arcanesql 
sudo docker ps -a 

# Stopping the container will help save memory. If you want to start it
# back up, simply use
sudo docker container start arcanesql 

# You can also delete the docker container all together. First, stop it,
# then use the rm command to remove it.
sudo docker stop arcanesql 
sudo docker rm arcanesql

# You can also combine these into a single step using the force switch
sudo docker rm --force arcanesql

# Now we can use the listing command to validate it is gone
sudo docker ps -a 

# This removed the container, but the downloaded image for
# SQL Server is still on our system. Let's verify this:
Clear-Host
sudo docker image ls 

# We can remove the image using the same name we used to pull it
sudo docker image rm mcr.microsoft.com/mssql/server:2017-latest

# And let's verify it is gone
Clear-Host
sudo docker image ls 
