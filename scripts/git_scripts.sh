## Universal command execution script for git ##

# This script
function hello_git
{
    echo "-------------"
    git config user.name "Nikita Chernyshev"
    git config user.email "nikitosss140604@gmail.com"
}

# This script
function gst
{
    echo "---- Information about a git in the current folder ----"
    echo "-------------------------------------------------------"
    echo "--------- Last commits in  the current branch ---------"
    git branch -v
    echo "---- Git status ----"
    git status
}

# This script
function ga 
{
    echo "-------------------------------------------------------"
}