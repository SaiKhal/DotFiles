Please analyze and fix the Shortcut story: $ARGUMENTS.

Follow these steps:

1. Use `short story <id>` to get the issue details
    - Use the Figma API to view any designs. My PAT is stored in the FIGMA_PAT environment variable
2. Check for existing notes file:
    - Use Glob tool with pattern `<id>*.md` (NOT `**/<id>*.md`) and path `/Users/sai/Library/Mobile Documents/iCloud~md~obsidian/Documents/SecondBrain/Grailed/Tickets`
    - If a file exists, read it and append new findings to it as a running log
    - If no file exists, create a new file called `{IssueID}_{StoryType}_{ShortSummary}.md` where {ShortSummary} is based on the issue details (max 4 words, titlecased)
    - IMPORTANT: Never overwrite existing thoughts - always append as a running conversation log
3. Understand the problem described in the issue. Digest all images and urls
4. Search the codebase for relevant files
5. Think hard of multiple solutions to the issue
6. For bugs think hard of multiple possible explanations if ambigious
7. After approval, offer to implement the necessary changes to fix the issue
8. If possible recommend and write tests to verify the fix
