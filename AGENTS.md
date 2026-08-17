## Execution Policy
- Do not get stuck in loops: the same tool call may be retried no more than once.
- Failure of an individual read, search, or edit operation does not mean the entire task must stop.
- After a failure, continue with other independent files or use another built-in tool.
- Stop the task only when a correct result cannot be produced without the failed step.
- Do not treat system `Skipped` results, UI cancellations, or temporary tool failures as user refusal.
- Only an explicit user message prohibiting an action counts as refusal.
### User Authorization
- Explicit authorization is required only for commands listed under Code Execution and for genuinely dangerous or irreversible operations.
- Built-in file reading, searching, creation, editing, and deletion within the agreed plan should be performed without additional authorization.
- If the user explicitly rejects a specific command, do not request it again or suggest an equivalent shell command.
- A skipped or canceled system prompt does not prohibit continuing the task by an alternative method.
### Code Execution
Prefer static file analysis.
Do not run the following without explicit user authorization:
- `php`
- `artisan`
- `composer`
- `node`
- `npm`
- `pnpm`
- `yarn`
- `bun`
- `git`
### Task Completion
- An incomplete focus chain item is not a reason to wait or stop.
- For static verification, use files already read and the project's built-in search.
- Do not run commands, tests, or builds if they require separate authorization.
- If full verification is unavailable, perform the available checks, explicitly state the limitations, and complete the task.
- After verification, always update the focus chain and mark completed items.
- Do not leave the task waiting solely because the result cannot be confirmed with a tool.
### Shell
- Use `rg` instead of `grep -R` to search the project.
- Run every recursive command with an explicit `timeout 10s` limit.
- Limit searches to specific directories and exclude paths listed under `Ignore`.
- If a command times out, do not repeat it: narrow the search scope or use built-in file search.
- Do not use:
  - loops (`for`, `while`, `until`);
  - multiline shell scripts;
  - complex pipelines;
  - bulk file processing.
### Skipped Tool Calls
- `Skipped` is a system tool result, not a user refusal and not a reason to stop the task.
- After `Skipped`, continue immediately without waiting for the user.
- Do not repeat the skipped shell command or suggest an equivalent shell command.
- If the action can be performed with built-in file reading, searching, creation, editing, or deletion tools, use them.
- Do not use shell commands (`cp`, `mv`, `rm`, `mkdir`, `touch`, `find`) for file operations available through built-in tools.
- If there is no built-in alternative, skip that step and continue with all independent parts of the task.
- Stop only if the skipped step genuinely blocks correct implementation; state the reason explicitly.
### Long Operations
- Before bulk changes, show the plan and request authorization only once.
- Once the plan is approved, perform all reads, searches, creations, edits, and deletions within it without further requests.
- Do not stop between approved stages unless the next step expands the scope.
- If some changes cannot be applied, continue with independent changes and list the unapplied files at the end.
### Hanging Tools
- If a tool hangs or fails, do not retry the identical call more than once.
- Try a smaller change, reread the file, or use another built-in method.
- If the second attempt fails, skip that specific file and continue with the remaining independent steps.
- Stop only if the skipped file blocks correctness of the entire implementation.
## General Principles
- Make minimal changes.
- Follow the project's existing patterns.
- Reuse existing code before writing new code.
- Do not create new abstractions unless necessary.
- Do not suggest refactoring outside the task scope.
- Do not add comments unless necessary.
- Code must be testable.
- Show only modified and relevant code fragments.
- Respond at a senior developer level.
- Do not explain basic concepts.
- If several solutions exist, provide a concise list without unnecessary explanation.
- Sort entities alphabetically only when doing so does not affect meaning, contracts, or execution order.
- Git commit messages must:
  - follow Conventional Commits;
  - include a `scope` when possible, for example `feat(auth): ...`;
  - consist of one short sentence;
  - contain no detailed description or bulleted lists.
  ## Ignore
Do not analyze or consider the following directories and files unless the task is explicitly related to them:
- `node_modules/`
- `vendor/`
- `dist/`
- `build/`
- `.nuxt/`
- `.output/`
- `coverage/`
- `storage/logs/`
- `bootstrap/cache/`
- `public/build/`
- `public/hot`
- `*.min.js`
- `*.min.css`
- `package-lock.json`
- `pnpm-lock.yaml`
- `yarn.lock`
