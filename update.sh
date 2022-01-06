#!/bin/bash

if [ ! -d master ]; then
    mkdir master
fi

if [ ! -s master-strict ]; then
    ln -s master master-strict
fi

pushd master > /dev/null

for src in \
    https://raw.githubusercontent.com/jetstack/cert-manager/master/deploy/crds/crd-certificates.yaml \
    https://raw.githubusercontent.com/jetstack/cert-manager/master/deploy/crds/crd-clusterissuers.yaml \
    https://raw.githubusercontent.com/openfaas/faas-netes/master/artifacts/crds/openfaas.com_functions.yaml; do

    ../scripts/openapi2jsonschema.py $src
done

popd > /dev/null

for link in v1.21.0; do
    if [ ! -s $link ]; then
        ln -s master $link
    fi
    if [ ! -s $link-strict ]; then
        ln -s master ${link}-strict
    fi
done