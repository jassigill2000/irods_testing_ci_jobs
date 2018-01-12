#!/bin/bash -xe

# Settable
JOB_ROOT_DIRECTORY=${GLOBAL_PARAMETER_JOB_OUTPUT_ROOT_DIRECTORY:?}/${JOB_NAME:?}/${BUILD_NUMBER:?}

pushd ${GLOBAL_PARAMETER_DIRECTORY_CONTAINING_PYTHON_REPOSITORIES:?}/irods_testing_zone_bundle

set +e
python upgrade_irods_deployment_and_run_tests.py \
    --deployment_name ${BUILD_TAG:?} \
    --zone_bundle_input ../zone_bundles/${PARAMETER_ZONE_BUNDLE:?} \
    --version_to_packages_map \
      deployment-determined ${PARAMETER_UPGRADE_FROM_PACKAGES_DIR:?} \
    --upgrade_packages_root_directory ${PARAMETER_UPGRADE_TO_PACKAGES_DIR:?} \
    --leak_vms ${PARAMETER_LEAK_VMS:?} \
    --test_type topology_resource  \
    --output_directory ${JOB_ROOT_DIRECTORY}
    
TEST_RETURN=$?
set -e

popd

cp ${JOB_ROOT_DIRECTORY}/resource1.example.org/* ${WORKSPACE}

exit ${TEST_RETURN}
