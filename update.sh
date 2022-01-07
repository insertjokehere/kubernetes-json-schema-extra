#!/bin/bash

rm -r master
mkdir master

if [ ! -s master-strict ]; then
    ln -s master master-strict
fi

pushd master > /dev/null

for src in \
    https://raw.githubusercontent.com/jetstack/cert-manager/v1.5.4/deploy/crds/crd-certificates.yaml \
    https://raw.githubusercontent.com/jetstack/cert-manager/v1.5.4/deploy/crds/crd-clusterissuers.yaml \
    https://raw.githubusercontent.com/openfaas/faas-netes/master/artifacts/crds/openfaas.com_functions.yaml; do

    FILENAME_FORMAT=\{kind\}-\{group\}-\{version\} ../scripts/openapi2jsonschema.py $src
done

popd > /dev/null

for link in v1.21.0 v1.21.1 v1.21.2; do
    if [ ! -s $link ]; then
        ln -s master $link
    fi
    if [ ! -s $link-standalone ]; then
        ln -s master ${link}-standalone
    fi
done