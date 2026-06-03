# Release

1. Bump `.claude-plugin/plugin.json` `version`.
2. Confirm `.mcp.json` pins the intended `@askthew/mcp-plugin` version.
3. Run `claude plugin validate .`.
4. Push a tag or update the marketplace source ref.
5. In Claude Code, run `/plugin update askthew-paid@askthew` or restart with marketplace auto-update enabled.
