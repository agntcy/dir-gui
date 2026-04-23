# Release

This document outlines the process of creating a new release
for the Directory GUI.

## 1. Create a release branch

Create a branch for the new release:

1. Update the GUI version in:
    - `pubspec.yaml`
    - `.github/ISSUE_TEMPLATE/bug_report.yml`
2. Update the dependencies if necessary:
    - `.github/workflows/gui-ci.yaml` (dir-ctl version)
3. Add an entry to `CHANGELOG.md`

## 2. Create and push tags

After the release branch is merged, update your main branch:

```sh
git checkout main
git pull origin main
```

To trigger the release workflow, create and push the release tag
for the last commit:

```sh
git tag -a v1.0.1
git push origin v1.0.1
```
