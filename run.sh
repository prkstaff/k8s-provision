#!/bin/bash


print_commands_help () {
cat <<EOF
options:
provision: provision an environment
destroy: destroy an environment
EOF

}

print_provision_help () {
cat <<EOF
options:
--env: pass the environment [dev/prod]
EOF

}

selected_environment=""
run_provision=false
run_destroy=false
if [ "$1" == "provision" ];
then
  shift
  while [ "$1" != "" ]; do
    case $1 in
      --env ) shift
          selected_environment="$1"
          run_provision=true
                      ;;
      * )
        print_provision_help
        exit 2
      esac
      shift
  done
elif [ "$1" == "destroy" ];
then
  shift
  while [ "$1" != "" ]; do
    case $1 in
      --env ) shift
          selected_environment="$1"
          run_destroy=true
                      ;;
      * )
        print_provision_help
        exit 2
      esac
      shift
  done
else
  print_commands_help
  exit 2
fi


# Provision with --env passed
if [ "$selected_environment" != "" ] && [ $run_provision == true ];
then
  case $selected_environment in
    "prod" ) source scripts/provision.sh prod
      ;;
    "dev" ) source scripts/provision.sh dev
      ;;
    * ) echo "invalid environment, choose between dev and prod"
      exit 2
      ;;
  esac
 # Provision with --env passed
elif [ "$selected_environment" != "" ] && [ $run_destroy == true ];
then
  case $selected_environment in
    "prod" ) source scripts/destroy.sh prod
      ;;
    "dev" ) source scripts/destroy.sh dev
      ;;
    * ) echo "invalid environment, choose between dev and prod"
      exit 2
      ;;
  esac
else
  print_commands_help
fi
