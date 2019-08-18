# Github-Release-Action
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

### Old workflow
```hcl
workflow "Publish Release" {
  on = "push"
  resolves = ["create release"]
}

action "create release" {
  uses = "elgohr/Github-Release-Action@master"
  args = "MyReleaseMessage"
  secrets = ["GITHUB_TOKEN"]
}
```

## Argument

The message which should appear in the release
