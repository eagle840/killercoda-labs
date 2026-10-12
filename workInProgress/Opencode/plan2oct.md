# Plan for Updating the OpenCode Killercoda Lab (2 Oct 2026)

This plan addresses corrections to the notes file and concrete improvements to fold those items into the existing lab. 

## 1. Corrections to notes.md

First, fix factual inaccuracies and typos in `notes.md`:

| Issue | Current | Correct | Notes |
|---|---|---|---|
| Typos | "verious", "intructions", "queiries", "specization", "conversional", "useing" | "various", "instructions", "queries", "specialization", "conversational", "using" | Fix spelling throughout |
| V2 API | "has an API/server running on the backend" | Clarify: OpenCode v2 can run as a server/API (e.g. `opencode serve` or HTTP API capabilities). Document exact command if available. | Verify current v2 CLI subcommands. |
| Sessions | "opencode session command, inc list, export, delete" | "opencode session" with subcommands like `list`, `delete`, `export` etc. Document syntax clearly. | Be precise about actual subcommands. |
| Reset path | `rm -rf ~/.local/store/opencode` | Include both common paths: `~/.local/share/opencode` and `~/.local/store/opencode` depending on install; also `~/.config/opencode` for config. Recommend checking with `opencode debug paths`. | More accurate reset guidance. |
| Commands dir | `~/.config/opencode/commands/intructions.md` | `~/.config/opencode/commands/instructions.md`. Also note custom slash commands via .md files with frontmatter (`description`, optional `name`). | Correct filename. |
| TSEB | Good concept | Expand: Tone, Style, Expertise, Behavior - add brief explanation/examples. | Educational value. |
| Upgrade | "don't mix install types" | Strengthen: if installed via curl script, upgrade via `opencode upgrade`; if installed via package manager (apt/brew), use package manager. | Important operational note. |

## 2. New Content to Add to Lab

Fold missing items from notes into structured steps or as additions to existing steps.

### Suggested New Step 9: OpenCode Sessions, Commands & Mini Mode (or split)
Add a new step covering:
- Opening a project: `opencode ~/my-project` or `opencode .`
- Sessions: `opencode session list`, switching sessions, exporting/deleting
- Mini interface: `opencode mini` (compact mode)
- Custom slash commands: create `~/.config/opencode/commands/` with example instructions.md
- Debug: `opencode debug paths`, reset guidance (safe vs destructive)

### Suggested New Step 10: OpenCode API/Server (Advanced)
Based on "using opencode api":
- Introduction to v2 server capabilities
- Starting server (if `opencode serve` exists) 
- Basic API usage with curl/examples
- Security note (local-only by default)
- Tie to "mixed in with server" from notes

### Enhancements to Existing Steps

| Step | Enhancement | Rationale |
|---|---|---|
| Step 1 (Install) | Add version check, upgrade instructions, note about mixed install types. Also add `--version` after install. | Matches notes and best practice. |
| Step 2 (Launch) | Show `opencode .` / opening specific project. Mention model selection via `/models`. | Practical usage. |
| Step 6 (Project Rules) | Clarify AGENTS.md vs agents.md conventions in OpenCode. Show `/init` context. Add TSEB guidance when writing agent instructions. | From notes' TSEB. |
| Step 7 (Skills) | Link to skill guide better; clarify difference between agents vs skills (reference session doc). | Notes + session-ses_faca.md has good content. |
| Step 8 (LSP) | Already good; add where config lives (`opencode.json`/config). | Complements guide. |
| Intro | Add "Last updated: 2 Oct 2026" per convention. Add disclaimer if production safety relevant? OpenCode is dev tool - maybe note it's for learning. | Matches intro.md convention from rules. |
| Resources | Populate `resources.md` with links (opencode.ai docs, v2 API, skills, LSP) and move old notes/code as per convention. Currently blank. | Convention says create resources.md with extra notes/links/old code. |

## 3. JSON/Structure Improvements

- Add version to description per convention: e.g. "Learn to master OpenCode for AI-powered software development (v1.1)" (bump appropriately)
- Title is ~6 words - "Mastering OpenCode: Advanced AI Development" ok
- Add assets if needed? Maybe docker-compose if referenced, but lab seems CLI-focused. 
- Time 30 min - reasonable
- Backend ubuntu2004 - fine for CLI

## 4. Specific File Edits Needed

1. **notes.md**: Fix typos, clarify API/server, sessions, reset paths, commands filename, TSEB expansion.
2. **intro.md**: Add "Last updated: 2026-10-02" and maybe brief note about v2.
3. **index.json**: Add version suffix to description (e.g. "(v0.2)" or "(v1.0)"), consider adding new steps.
4. **resources.md**: Replace "blank" with structured content (links, references to guides, notes migrated from old).
5. **New/updated steps**: Create step9.md (Sessions/Debug/Mini/Commands), step10.md (API/Server) OR integrate into existing. Also update step1/step2 to include items.
6. **plan.md**: Keep as reference; our new plan2oct.md is the action plan.

## 5. Recommended Implementation Order

1. Fix `notes.md` (correctness first)
2. Update `intro.md` (date + context)
3. Populate `resources.md` (carry notes/links)
4. Update `index.json` (description version, possibly add steps)
5. Create step9.md and step10.md for new content, or extend existing steps
6. Update affected existing steps (step1, step2, step6, step7)
7. Validate `index.json` is valid JSON
8. Update `finish.md` if new skills learned
9. Mark progress if using scenario_ideas.md (not shown here)

## 6. Concrete Draft Updates

### Example intro.md addition
```markdown
# Mastering OpenCode: Advanced AI Development
*Last updated: 2026-10-02*

In this lab, you will master **OpenCode v2**, an AI-powered CLI tool...
```

### Example index.json description
```json
"description": "Learn to master OpenCode v2 for AI-powered development workflows (v0.2)",
```

### Example step9 outline
- Title: "Sessions, Mini Mode, Debug & Custom Commands"
- Open project with path
- Session management
- `opencode mini`
- Create custom command in `~/.config/opencode/commands/`
- Debug paths and reset

## 7. Verification Checklist

- [ ] notes.md typos fixed and info accurate
- [ ] All new commands tested conceptually against v2 conventions
- [ ] index.json validates as JSON
- [ ] Steps runnable in environment (ubuntu2004)
- [ ] Resources.md populated with useful refs
- [ ] Intro has update date
- [ ] Version in description present
- [ ] No production code issues (dev tool only)

This plan balances preserving existing good content while properly integrating the notes and improving accuracy.