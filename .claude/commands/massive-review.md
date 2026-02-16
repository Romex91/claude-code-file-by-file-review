---
description: "Review a massive PR file-by-file, looking for problems in each changed file"
allowed-tools: ["Bash", "Read", "Grep", "Glob", "Task"]
---

You are reviewing a massive PR file-by-file. Your goal is to review every changed file against the user's review instructions and produce a GOOD/BAD verdict for each file.

## Step 1: Initialize

Run this command to set up the review:
```
massive-CC-review/set-review-instructions "$ARGUMENTS"
```

## Step 2: Get file count

Run:
```
massive-CC-review/get-number-of-changed-files
```

This gives you the total number N of changed files.

## Step 3: Review all files in parallel

Use the Task tool to review files in parallel. Launch batches of ~10 Task agents concurrently. Each Task agent should:

For each Task, provide these instructions:

```
You are reviewing a single file from a massive PR. You have access to the Bash tool.

1. Run: `massive-CC-review/print-git-diff <INDEX>` (where <INDEX> is the file number assigned to you)
2. Read the output carefully. It contains:
   - The file path and index
   - The git diff showing what changed
   - The full file before the change
   - The full file after the change
   - The review instructions to evaluate against
3. Analyze the change against the review instructions
4. Make your verdict:
   - If the change looks correct and has no issues per the review instructions, run:
     `massive-CC-review/mark-git-diff-as-good <INDEX> "<concise reason>"`
   - If you find a problem per the review instructions, run:
     `massive-CC-review/mark-git-diff-as-bad <INDEX> "<concise description of the problem>"`
5. Return a one-line summary: "File <INDEX> (<filepath>): GOOD|BAD — <reason>"
```

Use `subagent_type: "Bash"` for each Task agent. Assign each agent a specific file index.

Process all N files. Launch them in batches of 10 concurrently (files 1-10, then 11-20, etc.).

## Step 4: Print summary

After all files have been reviewed, read all files in `/tmp/massive-review/report/` and print a summary:

1. Total files reviewed
2. Count of GOOD vs BAD
3. List of all BAD files with their reasons (read from the `_BAD.txt` files)
4. A brief overall assessment

Format the summary clearly with markdown.
