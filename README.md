# addLabels - GitHub Action

![GitHub issues](https://img.shields.io/github/issues/IamPekka058/addLabels)
![GitHub pull requests](https://img.shields.io/github/issues-pr/IamPekka058/addLabels)
![License: MIT](https://img.shields.io/github/license/IamPekka058/addLabels)

A fast GitHub Action to add specific labels (provided as a JSON array) to a pull request or issue using the GitHub REST API.

## Usage

```yaml
- name: Add labels to PR or Issue
  uses: IamPekka058/addLabels@v1
  with:
    labels: '["bug", "help wanted"]'
    github_token: ${{ secrets.GITHUB_TOKEN }}
```

## Inputs

| Name         | Description                                                      | Required |
|--------------|------------------------------------------------------------------|----------|
| labels       | A JSON array of labels to add, e.g. ["bug", "help wanted"].     | Yes      |
| github_token | GitHub token to authenticate.                                    | Yes      |

## How it works

This action detects whether the workflow was triggered by a pull request or an issue and adds the specified labels using the GitHub REST API. The labels input must be a valid JSON array.

## License

MIT