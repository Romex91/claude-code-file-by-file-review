# Massive PR Review for Claude Code

File-by-file PR review using Claude Code. When a PR touches hundreds of files, this toolset reviews each changed file individually and produces a structured GOOD/BAD report.

## Install

```bash
git clone https://github.com/anthropics/claude-code-file-by-file-review.git
cd claude-code-file-by-file-review
./install.sh
```

## Usage

Open Claude Code in any repo, checkout the branch you want to review, and run:

```
/file-by-file-review Check for missing error handling
```

The argument is your review focus — what Claude should look for in each file. More examples:

```
/file-by-file-review Look for broken imports or references to deleted modules
/file-by-file-review Check that all React components handle loading and error states
/file-by-file-review Verify the migration from class components to hooks is correct
```

Claude will review every changed file in parallel and print a summary of all problems found.

## Report

Results are written to `/tmp/massive-review/report/` (auto-cleans on reboot):

```
/tmp/massive-review/report/
  src__utils__foo.ts_GOOD.txt
  src__api__client.ts_BAD.txt
```

Each file contains the file path, the git diff command to reproduce, and the verdict with reason.

## How it works

1. Fetches latest `origin/main` (or `origin/master`) and computes the merge-base
2. Lists all changed files between the merge-base and HEAD
3. Reviews each file in parallel using Claude Code subagents (batches of 10)
4. Each subagent sees the diff, full file before/after, and your review instructions
5. Marks each file GOOD or BAD with a concise reason
6. Prints a final summary listing all BAD files
