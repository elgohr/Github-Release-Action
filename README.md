# Github-Release-Action
[![Actions Status](https://github.com/elgohr/Github-Release-Action/workflows/Test/badge.svg)](https://github.com/elgohr/Github-Release-Action/actions)

Publish Github releases

## Usage

### New workflow
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
        GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
      with:
        args: MyReleaseMessage

```

## Argument

The message which should appear in the release
