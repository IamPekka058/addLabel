# addLabel

A fast GitHub Action to add specific labels to a pull request or issue using the GitHub CLI.

## Usage

```yaml
- name: Add labels to PR or Issue
  uses: IamPekka058/addLabel@v1
  with:
    labels: 'bug|help wanted'
    github_token: ${{ secrets.GITHUB_TOKEN }}
```

## Inputs

| Name         | Description                              | Required |
|--------------|------------------------------------------|----------|
| labels       | A `|` separated list of labels to add.    | Yes      |
| github_token | GitHub token to authenticate.             | Yes      |

## How it works

This action detects whether the workflow was triggered by a pull request or an issue and adds the specified labels using the GitHub REST API.

## License

MIT