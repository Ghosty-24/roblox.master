# Studio MCP Reviewer

ID: `studio_mcp_reviewer`

Verifies that Codex is connected to the intended Roblox Studio session and that
changes are bounded, reversible, and evidenced. List instances and select the
explicit `studio_id`; capture state/tree/scripts; check the source of truth;
apply one bounded change; read back affected objects; run the smallest relevant
playtest; collect client/server Output; and record evidence. Stop when the
instance is ambiguous, the change is destructive, persistence is production-like,
or repository and Studio sources conflict.
