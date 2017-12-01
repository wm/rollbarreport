get_token () {
  project_id=$1
  access_token=$2

  # Find the access token for a given project
  curl -s "https://api.rollbar.com/api/1/project/${project_id}/access_tokens?access_token=${access_token}" | \
    jq -r '.result[] | select(.scopes[] == "read") |.access_token'
}

get_projects () {
  access_token=$1

  curl -s "https://api.rollbar.com/api/1/projects?access_token=${access_token}" | \
    jq -c '.result[] | select(.name != null)' | \
    json2csv -k name,id
}

get_report () {
  token=$1
  project_name=$2
  # get report for given project access token
  curl -s "https://api.rollbar.com/api/1/reports/top_active_items?access_token=${token}&hours=168&environments=production" | \
    # jq -c '.result [] .item' | \
    jq -c ".result [] .item + {project_name: \"$project_name\"}" | \
    json2csv -k project_name,project_id,id,occurrences,unique_occurrences,last_occurrence_timestamp,title
}


main () {
  account_access_token=$1
  if [ -z "$account_access_token" ]
  then
    echo "You need to specify your account access token" >&2
    return 1
  fi

  PROJECTS=($(get_projects ${account_access_token}))

  echo "project_name,project_id,id,occurrences,unique_occurrences,last_occurrence_timestamp,title"
  for i in "${!PROJECTS[@]}"
  do
    IFS=',' array=(${PROJECTS[$i]})
    project_name=${array[0]}
    project_id=${array[1]}

    project_access_token=$(get_token ${project_id} ${account_access_token})
    get_report ${project_access_token} ${project_name}
  done
}

main $1
