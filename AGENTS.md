## Execution Policy
- Do not get stuck in loops. If an action, command, or tool fails, make at most one retry.
- If the issue can be worked around, use an alternative approach and continue.
- If the task cannot be completed without the failed step, stop, briefly explain the reason, and ask the user for permission to proceed.
- Treat environment errors (EACCES, ENOENT, network errors, missing tools, permission errors, etc.) as terminal unless the user explicitly asked you to debug them.
### User Approval
- Explicit user approval overrides the execution restrictions in this file for the specifically approved command.
- After approval, execute the command immediately without requesting confirmation again or reconsidering whether it is allowed.
- If an approved command still cannot be executed, stop and report the exact reason instead of waiting or retrying.
### Code Execution
Prefer static analysis of files.
Do not run the following without the user's explicit permission:
- `php`
- `artisan`
- `composer`
- `node`
- `npm`
- `pnpm`
- `yarn`
- `bun`
- `git`
### Shell
Use only simple one-off commands with a timeout of no more than 10 seconds.
Do not use:
- loops (`for`, `while`, `until`);
- multi-line shell scripts;
- complex pipelines;
- bulk file processing.
### Long Operations
Before performing large-scale searches, modifying many files, or starting other long-running operations, first present the plan and ask the user for permission.
### Hanging Tools
If a tool hangs or takes too long to respond, do not wait indefinitely. Cancel the attempt, briefly explain the issue, and continue using an alternative approach if possible.
### General Rules
- Show only relevant code fragments.
- Answer at senior level.
- Do not explain basic concepts.
- If multiple solutions exist, provide a short list without extra explanations.
- Sort entities alphabetically only when it does not affect meaning, contracts, or execution.
-  Git commit messages must follow the Conventional Commits specification, include a scope when reasonably identifiable (for example `feat(auth): ...`), be limited to a single short sentence, and must not include detailed descriptions or bullet lists.
### Ignore
Do not analyze or consider the following files and directories unless the task explicitly requires them:
- node_modules/
- vendor/
- dist/
- build/
- .nuxt/
- .output/
- coverage/
- storage/logs/
- bootstrap/cache/
- public/build/
- public/hot
- *.min.js
- *.min.css
- package-lock.json
- pnpm-lock.yaml
- yarn.lock
