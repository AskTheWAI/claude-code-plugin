#!/usr/bin/env bash
set -euo pipefail

cat <<'JSON'
{
  "hookSpecificOutput": {
    "hookEventName": "SessionStart",
    "additionalContext": "Ask The W paid Claude Code plugin is available in this workspace. This is the paid workspace plugin, not the free MCP package wrapper. Use it without free caps after the install is bound to a paid workspace.\n\nRequired flow: call capture_session_signal for setup_complete at session start, after meaningful state changes, after verification, and final_summary before the final reply. Omit scopeKey unless deliberately overriding the workspace default; the MCP server resolves scope from the active Claude project.\n\nPaid workspace gate: if a protected tool returns needs_signup, ask the user for email, call askthew_start_signup, ask for the six-digit code, call askthew_complete_signup, then start workspace binding. If a protected tool returns needs_paid_workspace, call askthew_start_workspace_bind, ask the user to open the returned URL and confirm the displayed code, then call askthew_check_workspace_bind until it reports completed. Retry the original setup_complete capture after signup and binding complete.\n\nPaid work surface: push compact signals with capture_session_signal, durable decisions with create_decision, and next-move guidance with coach/recap plus explicit follow-up signals or decisions when a next move is chosen. Paid workspace-bound installs should be treated as unlimited for signals, decisions, recaps, coaching, and next-move capture. Keep payloads compact and never send transcripts, secrets, credentials, or large copied content."
  }
}
JSON
