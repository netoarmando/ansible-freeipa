#!/bin/bash -eux

# this script is intended to be run within container
#
# distro-specifics
source "${IPA_TESTS_SCRIPTS}/variables.sh"

# rm -rf "$IPA_TESTS_LOGSDIR"
# mkdir "$IPA_TESTS_LOGSDIR"
pushd /ansible-freeipa/tests/integration-tests

cat > ~/.ansible.cfg <<EOL
[defaults]
roles_path   = /ansible-freeipa/roles
library      = /ansible-freeipa/plugins/modules
module_utils = /ansible-freeipa/plugins/module_utils
EOL

# ansible-doc ipahost

tests_result=1
{ py.test --multihost-config=/root/.ipa/ipa-test-config.yaml && tests_result=0 ; } || \
    tests_result=$?

# fix permissions on logs to be readable by Azure's user (vsts)
# chmod -R o+rX "$IPA_TESTS_LOGSDIR"

# find "$IPA_TESTS_LOGSDIR" -mindepth 1 -maxdepth 1 -not -name '.*' -type d \
#     -exec tar --remove-files -czf {}.tar.gz {} \;

exit $tests_result
