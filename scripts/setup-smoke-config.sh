#!/bin/bash

# Edit the smoke test's admin settings so they have the necessary GitHub credentials to run the smoke test.
set -o errexit

mkdir -p clients
cat >> smoke/internal/testdata/admin_settings.yml <<EOF
credentials: {
  github: "$1",
}
auth:
    github:
      app_id: $GITHUB_APP_ID
      default_owner: "evergreen-ci"
      default_repo: "evergreen"


# Do not edit below this line
expansions:
  github_app_key: |
EOF

# Write the GitHub app key to a file for easier formatting
echo "$GITHUB_APP_KEY" > app_key.txt
# Linux and MacOS friendly command to add 4 spaces to the start of each line
sed -i'' -e 's/^/    /' app_key.txt
# Append the formatted GitHub app key to the admin_settings.yml file
cat app_key.txt >> admin_settings.yml