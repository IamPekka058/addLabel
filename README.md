# addLabels - GitHub Action

![GitHub issues](https://img.shields.io/github/issues/IamPekka058/addLabels)
![GitHub pull requests](https://img.shields.io/github/issues-pr/IamPekka058/addLabels)
![License: MIT](https://img.shields.io/github/license/IamPekka058/addLabels)

A fast GitHub Action to add specific labels to a pull request or issue using the GitHub REST API.

## Usage

```yaml
- name: Add multiple labels to PR or Issue
  uses: IamPekka058/addLabels@v2
  with:
    labels: |
      - bug
      - help wanted
    github_token: ${{ secrets.GITHUB_TOKEN }}
```
```yaml
- name: Add label to PR or Issue
  uses: IamPekka058/addLabels@v2
  with:
    labels: bug
    github_token: ${{ secrets.GITHUB_TOKEN }}
```

## Inputs

| Name         | Description                                                      | Required |
|--------------|------------------------------------------------------------------|----------|
| labels       | A list of labels to add.                                         | Yes      |
| github_token | GitHub token to authenticate.                                    | Yes      |

## How it works

This action detects whether the workflow was triggered by a pull request or an issue and adds the specified labels using the GitHub REST API. The labels input must be a valid YAML list (multiline, e.g. - bug - help wanted).

## License

[MIT](LICENSE)

<div align="center">
  <sub>Made with ❤️ in Bavaria </sub>
</div>