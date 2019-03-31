# Github-Hub-Action
Interacting with Github in an action

## Usage
An example workflow
```
workflow "Publish Release" {
  on = "push"
  resolves = ["create release"]
}

action "create release" {
  uses = "elgohr/Github-Hub-Action@1.0"
  args = "release create $(date +%Y%m%d%H%M%S)"
  secrets = ["GITHUB_TOKEN"]
}
```

## Argument

The actions you want to perform on Github
