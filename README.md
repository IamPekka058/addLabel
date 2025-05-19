# addLabel - GitHub Action

![GitHub issues](https://img.shields.io/github/issues/IamPekka058/addLabel)
![GitHub pull requests](https://img.shields.io/github/issues-pr/IamPekka058/addLabel)
![License: MIT](https://img.shields.io/github/license/IamPekka058/addLabel)


A fast GitHub Action to add specific labels, seperated by custom delimeter, to a pull request or issue using the GitHub CLI.

## Usage

```yaml
- name: Add labels to PR or Issue
  uses: IamPekka058/addLabel@v1
  with:
    labels: 'bug|help wanted'
    github_token: ${{ secrets.GITHUB_TOKEN }}
    delimiter: '|'
```

## Inputs

| Name         | Description                                                | Required |
|--------------|------------------------------------------------------------|----------|
| labels       | A list of labels to add, separated by the chosen delimiter.| Yes      |
| github_token | GitHub token to authenticate.                              | Yes      |
| delimiter    | Delimiter used to separate labels (default: <code>&#124;</code>).| No       |

## How it works

This action detects whether the workflow was triggered by a pull request or an issue and adds the specified labels using the GitHub REST API. You can customize the delimiter for your label list.

## License

MIT