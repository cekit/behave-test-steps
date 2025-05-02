#!/bin/bash
set -euo pipefail

# we expect to be run from the root of the behave-test-steps repository
test -d steps

# necessary to stop behave quitting early
mkdir -p features
touch features/blank.feature

cat <<EOF
<!doctype html>
<html>
  <head>
    <meta charset="utf-8" />
    <title>behave-test-steps steps documentation</title>
  </head>
  <body>
    <header>
      <h1>behave-test-steps steps documentation</h1>
    </header>
EOF

fork="cekit" # TODO: permit override from environment
branch="v1"
linkroot="https://github.com/${fork}/behave-test-steps/blob/${branch}/"

behave --dry-run --format=steps.catalog --no-summary              |
    sed -E 's!^((Given|When|Then).*)$!## \1\n!'                   | # turn steps into Mdwn headers
    sed -E "s#Location: (.*):(.*)#[\1:\2](${linkroot}\1\#L\2)\n#" | # mdwn-link to the implementation
    sed -E 's#^    ##'                                            | # stop preformatted descriptions                                            # convert to HTML
    python3 -m markdown                                             # convert to HTML

cat <<EOF

  </body>
</html>
EOF
