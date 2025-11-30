#!/usr/bin/env bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
pushd "${DIR}" > /dev/null
pipenv install --target backend/python-env
npm run dist
popd "${DIR}" > /dev/null
