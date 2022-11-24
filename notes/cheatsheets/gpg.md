---
tags: [gpg, Workbooks/Cheatsheet/gpg]
title: GPG Cheatsheet
created: '2022-11-24T07:18:12.243Z'
modified: '2022-11-24T07:19:12.127Z'

---
# GPG Cheatsheet
* [encrypt / decrypt](#encrypt-/-decrypt)

## encrypt / decrypt
| Action  | Default keybind                            | Comment                                     |
|:--------|:-------------------------------------------|:--------------------------------------------|
| encrypt | `gpg --recipient-id <id> --encrypt <file>` | encrypts `<file>` and produces `<file>.gpg` |
| decrypt | `gpg -dq <file>.gpg`                       | decrypts `<file>.gpg` to stdout             |
[Back](#GPG-Cheatsheet)


