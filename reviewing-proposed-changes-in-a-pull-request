# Github-Release-Action
[![Actions Status](https://github.com/elgohr/Github-Release-Action/workflows/Test/badge.svg)](https://github.com/elgohr/Github-Release-Action/actions)
[![Actions Status](https://github.com/elgohr/Github-Release-Action/workflows/Publish%20Release/badge.svg)](https://github.com/elgohr/Github-Release-Action/actions)

Publish Github releases

## Usage

```yaml
name: Publish Release
on: [push]
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@master
    - name: Create a Release
      uses: elgohr/Github-Release-Action@master
      env:
        GITHUB_TOKEN: ${{ secrets.RELEASE_TOKEN }}
      with:
        args: MyReleaseMessage

```
Please note, that you can't use `${{ secrets.GITHUB_TOKEN }}` as it isn't allowed to publish releases.

## Argument

The message which should appear in the release
