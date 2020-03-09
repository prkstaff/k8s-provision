#!/bin/bash

print_help () {
cat <<EOF
options:
--env: pass the environment [dev/prod]
EOF

}

ENVIRONMENT=""
while [ "$1" != "" ]; do
  case $1 in
    -env ) shift
      ENVIRONMENT="$1"
                    ;;
    * | --help | help )
      print_help
      exit 2
    esac
    shift
done
