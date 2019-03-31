# Github-Release-Action
Publish Github releases in an action

## Usage
An example workflow
```
workflow "Publish Release" {
  on = "push"
  resolves = ["create release"]
}

action "create release" {
  uses = "elgohr/Github-Release-Action@1.0"
  args = "UpdateDependencies"
  secrets = ["GITHUB_TOKEN"]
}
```

## Argument

The message which should appear in the release
