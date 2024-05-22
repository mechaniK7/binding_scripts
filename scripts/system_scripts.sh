## Universal script for executing system commands with quick access ##

# This script works only with classic-build workspaces
function setsrc 
{
    echo "---- Setting source this package to bashrc ----"
    echo source $(pwd)/install/setup.bash >> ~/.bashrc
    echo "---- Result:"
    echo "source $(pwd)/install/setup.bash"
}