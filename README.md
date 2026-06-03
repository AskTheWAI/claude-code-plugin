# Ask The W Paid Claude Code Plugin

Paid Claude Code plugin for Ask The W. It starts the Ask The W MCP server with paid workspace enforcement enabled, then gives Claude standing instructions for pushing signals, decisions, next moves, recaps, and coaching into the workspace.

This repo is the Claude Code plugin wrapper. The reusable MCP server code stays in `@askthew/mcp-plugin`.

## Install

Add the Ask The W Claude plugin marketplace:

```text
/plugin marketplace add AskTheWAI/claude-plugins
/plugin install askthew-paid@askthew
```

For project scope from the terminal:

```bash
claude plugin marketplace add AskTheWAI/claude-plugins --scope project
claude plugin install askthew-paid@askthew --scope project
```

## Team Settings

To offer the paid plugin to teammates when they open a repo, commit this to `.claude/settings.json`:

```json
{
  "extraKnownMarketplaces": {
    "askthew": {
      "source": { "source": "github", "repo": "AskTheWAI/claude-plugins" },
      "autoUpdate": true
    }
  },
  "enabledPlugins": {
    "askthew-paid@askthew": true
  }
}
```

Claude Code prompts each teammate to trust the marketplace. Users can skip the prompt; this is not a silent install.

## First Run

The plugin is paid-workspace only. If no local token exists, Claude should call `askthew_start_signup` and `askthew_complete_signup`. If the install is not bound to a paid workspace, Claude should call `askthew_start_workspace_bind`, ask the user to confirm the displayed code in Ask The W, then call `askthew_check_workspace_bind` until binding completes.

After binding, the plugin treats workspace usage as unlimited for signals, decisions, recaps, coaching, and next-move capture.

## Development

Validate the plugin:

```bash
claude plugin validate .
```

Run locally:

```bash
claude --plugin-dir .
```
