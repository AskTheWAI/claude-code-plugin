---
description: Paid Ask The W Claude Code workflow for unlimited workspace-bound signals, decisions, next moves, recaps, coaching, signup, and workspace binding.
---

# Ask The W Paid Workspace

Use this skill when working in a Claude Code repo with the paid Ask The W plugin enabled.

## What This Plugin Is

This is the paid Claude Code plugin wrapper. It is separate from `@askthew/mcp-plugin`, which remains the reusable MCP server package. The plugin starts that server with `ASKTHEW_REQUIRE_PAID=true`, so protected tools require a paid workspace binding before normal use.

Paid workspace-bound installs are intended for unlimited signals, decisions, recaps, coaching, and next-move capture. If a tool returns `free_limit_reached`, treat that as a server-side configuration problem for the paid install and tell the user.

## Required Startup Flow

Call `capture_session_signal` with `kind: "setup_complete"` at session start. Omit `scopeKey` unless deliberately overriding the workspace default.

If the tool returns `needs_signup`:

1. Ask the user for their email.
2. Call `askthew_start_signup({ email })`.
3. Ask for the six-digit code from email.
4. Call `askthew_complete_signup({ email, code })`.
5. Start the paid workspace bind flow.

If the tool returns `needs_paid_workspace`:

1. Call `askthew_start_workspace_bind`.
2. Ask the user to open the returned URL and confirm the displayed code in Ask The W.
3. Call `askthew_check_workspace_bind({ codeDisplay })` until it reports `completed`.
4. Retry the original `setup_complete` capture.

## Capture Cadence

Send compact signals with `capture_session_signal`:

- `setup_complete` at session start.
- `session_checkpoint`, `direction_change`, or `implementation_update` after meaningful progress or state changes.
- `verification_result` after tests, builds, validation, or manual QA.
- `final_summary` before the final reply.

Keep payloads short: summary, files touched, commands run, and useful metadata. Do not send transcripts, secrets, credentials, private tokens, or large copied content.

## Decisions

Use `create_decision` when a product, architecture, implementation, release, or workflow choice should be durable. Link source signals with `sourceSignalIds` when available.

## Next Moves

Use `coach` and `recap` to surface next moves from the paid workspace trail. When a next move is chosen, push it back as a compact signal and, if it represents a durable commitment, as a decision.

Useful signal metadata for next moves:

```json
{
  "nextMove": {
    "title": "Short action",
    "owner": "agent|user|team",
    "status": "proposed|accepted|completed",
    "reason": "Why this is the next best move"
  }
}
```

## Recovery

If startup capture was missed, send `setup_complete` as soon as you notice with `metadata.recovered_missed_startup=true`.
