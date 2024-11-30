# Github-Release-Action

[![Actions Status](https://github.com/elgohr/Github-Release-Action/workflows/Release/badge.svg)](https://github.com/elgohr/Github-Release-Action/actions)

Creates a plain Github release, without attaching assets or source code.

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
      uses: elgohr/Github-Release-Action@v5
      env:
        GH_TOKEN: ${{ secrets.GITHUB_TOKEN }}
      with:
        title: MyReleaseMessage
```

## Mandatory Arguments

### title
`title` is a message which should appear in the release. May contain spaces.

## Optional Arguments

### workdir
`workdir` can be used to specify a directory that contains the repository to be published.  

```yaml
with:
  title: MyReleaseMessage
  workdir: myDirectoryName
```

### tag
`tag` can be used to set the tag of the release.  

```yaml
with:
  title: MyReleaseMessage
  tag: MyTag
```

### prerelease
`prerelease` is used to publish a prerelease.  

```yaml
with:
  title: MyReleaseMessage
  prerelease: true
```

## Notes

`${{ secrets.GITHUB_TOKEN }}` can be used for publishing, if you configure the correct permissions.

This can be done by giving the Github token _all_ permissions (referred to as "Read and write permission") with the setting below available in Settings > Actions > General  
![Screenshot of permission setting](permissions.png)
OR alternatively it can be achieved via adding

```yaml
permissions:
  packages: write
  contents: write
```

to the concrete job creating the release. For more details see the [documentation on token permissions.](https://docs.github.com/en/actions/security-guides/automatic-token-authentication#modifying-the-permissions-for-the-github_token)

### GitHub Enterprise

To publish your release to self-hosted GitHub Enterprise, include `GH_ENTERPRISE_TOKEN` and `GH_HOST` as environment variables.  
For example:

```yaml
      - name: Create Release
        if: ${{ github.event.inputs.create_release }}
        uses: elgohr/Github-Release-Action@v5
        env:
          GH_ENTERPRISE_TOKEN: ${{ secrets.GITHUB_TOKEN }}
          GH_HOST: yourgithub.company.com
        with:
          title: "New release"
          tag: "v1.0.1"
```
