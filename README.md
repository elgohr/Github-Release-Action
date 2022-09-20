# Github-Release-Action

[![Actions Status](https://github.com/elgohr/Github-Release-Action/workflows/Release/badge.svg)](https://github.com/elgohr/Github-Release-Action/actions)

Publish Github releases

## Usage

```yaml
name: Publish Release
on:
  push:
    tags:
      - 'v*'
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v3
    - name: Create a Release
      uses: elgohr/Github-Release-Action@v4
      env:
        GITHUB_TOKEN: ${{ secrets.RELEASE_TOKEN }}
      with:
        title: MyReleaseMessage
```

## Notes

You can't use `${{ secrets.GITHUB_TOKEN }}` as it isn't allowed to publish releases.

The ``title`` field is a message which should appear in the release. May not contain spaces. 

The reasult of running this action will be a new GitHub release of your software, available for download in the tab on the right.

This release will contain the source code for the given tag, and also may contain binaries and supporting metadata, if those are installed in directory so-and-so. 
