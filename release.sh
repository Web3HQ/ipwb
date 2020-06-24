#!/bin/bash

git checkout master
git pull

# Update version in project
PYVAR="__version__ = "
VERSION_STRING=`date -u +0.%Y.%m.%d.%H%M`
FILE_NAME='__init__.py'

# Update ipwb version
echo $PYVAR\'$VERSION_STRING\'>'ipwb/'$FILE_NAME

# Push to GitHub
git add 'ipwb/'$FILE_NAME
git commit -m "RELEASE: Bump version to "$VERSION_STRING

# Create a tag in repo
TAG_NAME='v'$VERSION_STRING
git tag $TAG_NAME
git push
git push origin $TAG_NAME

# The `.github/workflows/dist.yml` Workflow is triggered automatically
# when the repo is tagged by running this Shell script
# or manually creating a relase in GH.
# In either case, the Workflow will build the Python package
# in GH's CI infrastructure and publish it to PyPI.
