#!/bin/bash

rm -r schemas
mkdir schemas

pushd schemas > /dev/null

for src in \
    https://raw.githubusercontent.com/jetstack/cert-manager/v1.5.4/deploy/crds/crd-certificates.yaml \
    https://raw.githubusercontent.com/jetstack/cert-manager/v1.5.4/deploy/crds/crd-clusterissuers.yaml \
    https://raw.githubusercontent.com/openfaas/faas-netes/master/artifacts/crds/openfaas.com_functions.yaml; do

    FILENAME_FORMAT=\{kind\}-\{group\}-\{version\} ../scripts/openapi2jsonschema.py $src
done

popd > /dev/null

for link in v1.21.0 v1.21.1 v1.21.2; do
    if [ -e $link ]; then
        rm -rf $link
    fi
    cp -r schemas $link
    if [ -e $link-standalone ]; then
        rm -rf $link-standalone
    fi
    cp -r schemas $link-standalone
done