# github_create_repo.sh created by Shivang Parikh
# Create Repository under Organization and Environment Branches (d,s,u,master)
#!/bin/bash
  repo_name=$1
  username=$2  
  org=$3
 
  if [ "$repo_name" = "" ]; then
    echo "-:- Which Repository Would You Like To Create (for ex. 'my-scripts') ? -:-"
    read repo_name
  fi
  
  if [ "$username" = "" ]; then
    echo "-:- Please Enter Your Github User Name -:-"
    read username
  fi
      
  if [ "$org" = "" ]; then
    echo "-:- Please Enter Your Organization (for ex. 'MyOrg') -:-"
    read org
  fi  
  
  echo "-------------------------------------------"
  echo "----- Creating New GitHub Repository ------"
  echo "-------------------------------------------"
  echo "--> Creating Github Repository :: '$repo_name' ..."
  echo " "
  #Cache Credentials For This Session
  git config --global credential.helper "cache --timeout=4800"
  #Public Repo
  curl -u "$username" https://api.github.com/orgs/$org/repos -d '{"name":"'$repo_name'"}'  
  #Private Repo
  #curl -u "$username" https://api.github.com/orgs/$org/repos -d '{"name":"'$repo_name'", "private":"true"}'
  #User Repo (No Organization)
  #curl -u "$username" https://api.github.com/user/repos -d '{"name":"'$repo_name'"}'
  echo "Done..."
 
  echo "-------------------------------------------"
  echo "----- Creating Environment Branches -------"
  echo "-------------------------------------------"   
  git config --global user.name "$username"
  git clone https://$username@github.com/$org/$repo_name ~/temp/$repo_name   
  cd ~/temp/$repo_name
  echo "$repo_name" > README.md
  git add README.md
  git commit -m "Initial Commit"
  
  echo "--> Creating Branch 'master'..."  
  git push -u origin master
  echo "Done..." 
  
  echo "--> Creating Branch 'd'..."  
  git checkout -b d
  git push -u origin d
  echo "Done..." 
  
  echo "--> Creating Branch 's'..." 
  git checkout -b s
  git push -u origin s
  echo "Done..." 
 
  echo "--> Creating Branch 'u'..." 
  git checkout -b u
  git push -u origin u
  echo "Done..."
  
  echo "--> Cleaning up...."
  rm -rf ~/temp  
  echo "Done..."
  
  echo "-------------------------------------------"
  echo "------------- Thank You :) ----------------" 
  echo "--- Check Above For Errors (If Any...) ----"  
  echo "-------------------------------------------" 
