# scaffold-templates

This repository contains **data, not code**. It is consumed by
[`scaffold-cli`](https://github.com/yusronMu77/scaffold-cli) through a single contract file,
`jig.yaml`. The engine defines no scaffold, template, dimension, or variable of its own — every
one of them is declared here.

This guide covers the rules for writing or editing a `jig.yaml`. It does not walk through the
current folder layout — read the folders themselves for that.

## Quick example

A minimal `jig.yaml` combines four building blocks: a registry, a variable, a file, and a
dependency.

```yaml
name: "Example Template"
description: "Shown in `scaffold list`"

values:                          # 1. register any child folder — unregistered folders don't exist
  - name: "basic"
    default: true

variables:                       # 2. one CLI flag, one prompt, one default
  - name: "PackageName"
    flag: "package"
    default: "com.company.app"

files:                           # 3. source path -> generated output path
  - path: "Application.java.tpl"
    target: "src/main/java/{{ .PackagePath }}/Application.java"

dependencies:                    # 4. merged with every other level that contributes one
  - groupId: "org.springframework.boot"
    artifactId: "spring-boot-starter-web"
```

The rest of this guide explains the rules behind each of those blocks.

## The rules

### 1. Reserved names

The engine only recognizes four names. Everything else is yours to define.

| Name | Meaning |
|---|---|
| `jig.yaml` | the contract file itself |
| `_*.tpl` | a partial (`{{ define }}` block, not rendered on its own) |
| `scaffold`, `template`, `name` | the CLI's three positional arguments |
| `data` | the structured-data block |

If no dimension anywhere sets `required: true`, the engine falls back to treating a folder
literally named `templates` as required. That's the only case where a folder's *name* affects
behavior.

### 2. Every folder needs to be registered

A `values:` entry is what makes a child folder selectable. An unregistered folder is invisible to
`scaffold list` and can't be generated — this also keeps stray folders (`.git`, `.vscode`) from
being mistaken for real choices.

### 3. A jig's shape follows its fields, not its name

| It has... | It is a... | Behavior |
|---|---|---|
| `selector:` | selector | descends one level |
| only `values:` | registry | lists children, never rendered itself |
| `files:` / `variables:` / `dependencies:` | leaf | rendered |
| nothing above | inheriting leaf | valid — everything comes from a parent |

A **registry** encountered partway through a template's walk (not just at the top) is a **nested
dimension checkpoint** — same rule as #4 below, just reachable at any depth: one child is
`required: true` and auto-continues, every other child is an optional overlay with its own `flag`.
Nothing extra to declare; the shape alone is enough.

### 4. One required dimension per checkpoint

Exactly one dimension at a given checkpoint may set `required: true` - its walk is what continues
(at the top level, that means resolving `<template>`). Two at the same checkpoint is a
configuration error. A tree can have any number of checkpoints, at any depth — a template's own
folder can open a new one, and so can any of *its* children, recursively.

### 5. One precedence rule for everything

> **scaffold → version → dimension → template → overlay.** Later always wins.

For collections (files, variables, dependencies, ...), "wins" means replacing the entry with the
same identity — output path for files, `name` for variables, and so on. Two exceptions to know:

- **Dependencies merge field-by-field** instead of replacing outright, so a deeper level can change
  a `scope` or `version` without redeclaring the whole entry.
- **An overlay (e.g. `--style=microservice`) may not set a `default:` for a variable another level
  already declares.** Overlays apply last, so they'd always win — even when they don't know which
  version they landed on.

### 6. Variable or data?

- **`variables:`** — a scalar a user could type on the command line.
- **`data:`** — anything structured: lists, nested maps, code blocks.

Rule of thumb: **typeable as one flag → variable; structured → data.**

### 7. How a variable gets its value

**CLI flag → positional argument → `default:` in the jig → error.** `prompt:` is help text only;
this CLI never prompts interactively, so a missing required variable fails with a clear error
instead of hanging.

### 8. Mistakes fail loudly, never silently

An unknown field in a `jig.yaml`, an unregistered value, or two required dimensions — all of
these fail the run with a message naming the problem. There is no silent fallback anywhere in
the schema.

### 9. Removed fields — don't bring them back

`post_hooks`, `type:`, and `merge_yaml:` were removed because they were unused, ignored, or a
duplicate of `merge:`. If you need a post-generation command, model it on `verify:` instead.

### 10. Cross-dimension restrictions

Dimensions are independent by design, so a folder can't express "these two choices conflict." Use
`incompatible_with:` for that, keyed by flag name:

```yaml
incompatible_with:
  - "style:standalone"
```

This is the one place where *not* declaring a rule means the combination is allowed.

### 11. `verify:` is opt-in, not automatic

`verify:` commands run only via `scaffold lint --build`, never during `create`. A passing `lint`
proves templates render — it doesn't prove the output compiles. Use `verify:` for that proof.

## License

Distributed under the [MIT License](LICENSE).

## Support

If `scaffold-templates` saves you some boilerplate, consider supporting its development:

- ☕ [Ko-fi](https://ko-fi.com/yusronmu77)
- 💛 [Teer.id](https://teer.id/yusronmu77)
