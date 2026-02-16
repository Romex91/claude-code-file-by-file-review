# Massive PR Review for Claude Code

File-by-file PR review using Claude Code. When a PR touches hundreds of files, this toolset reviews each changed file individually and produces a structured GOOD/BAD report.

## Setup

Copy two directories into your project root:

```bash
cp -r massive-CC-review/ /path/to/your/repo/
cp -r .claude/commands/massive-review.md /path/to/your/repo/.claude/commands/
```

Make sure the scripts are executable (they should be already):

```bash
chmod +x /path/to/your/repo/massive-CC-review/*
```

That's it. No dependencies beyond git and bash.

## Usage

Checkout the branch you want to review, then run the slash command in Claude Code:

```
/massive-review Check for missing error handling
```

The argument is your review focus — what you want Claude to look for in each file. Examples:

```
/massive-review Look for broken imports or references to deleted modules
/massive-review Check that all React components handle loading and error states
/massive-review Verify the migration from class components to hooks is correct
```

Claude will:
1. Detect the merge-base against `origin/main` or `origin/master`
2. Review every changed file in parallel (batches of 10)
3. Mark each file as GOOD or BAD with a reason
4. Print a summary of all problems found

## Report output

All state lives in `/tmp/massive-review/` (auto-cleans on reboot):

```
/tmp/massive-review/
  review_instructions.txt    # your review focus
  base_ref.txt               # merge-base commit hash
  changed_files.txt          # list of changed files (one per line)
  report/
    src__utils__foo.ts_GOOD.txt
    src__api__client.ts_BAD.txt
```

Each report file contains:
```
src/api/client.ts
git diff <base>..HEAD -- src/api/client.ts
BAD: fetch calls missing error handling for network failures
```

## Scripts reference

All scripts live in `massive-CC-review/` and can be called standalone:

| Script | Usage | Description |
|--------|-------|-------------|
| `set-review-instructions` | `"<instructions>"` | Initialize review: fetch remote, compute merge-base, cache changed files |
| `get-number-of-changed-files` | (no args) | Print count of changed files |
| `print-git-diff` | `<file_index>` | Print diff, before/after content, and review instructions for file N (1-based) |
| `mark-git-diff-as-good` | `<file_index> "<reason>"` | Record GOOD verdict |
| `mark-git-diff-as-bad` | `<file_index> "<reason>"` | Record BAD verdict |

## Requirements

- [Claude Code](https://docs.anthropic.com/en/docs/claude-code)
- Git
- Bash
