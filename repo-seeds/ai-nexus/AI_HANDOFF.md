# AI Handoff

Updated: 2026-09-25

## Identity
- Project: AI Nexus
- Stable ID: P125
- Planned repository: `anastaysia94-sudo/ai-nexus`
- Related existing repository: `anastaysia94-sudo/ai-bridge`
- Portfolio index: `anastaysia94-sudo/anastaysia94-sudo`

## Purpose
Persist project context, source documents, decisions, evidence, and traceable model contributions so another LLM can continue without relying on one provider/account's chat history.

## Current state
Architecture/provider-role planning exists. Universal synchronization is not verified. AI Bridge may overlap, but no confirmed rename/merge exists.

## Resume protocol
1. Compare AI Nexus requirements against ai-bridge before duplicating implementation.
2. Persist one project, one source document, one decision, and one handoff.
3. Round-trip the handoff through a second model/tool.
4. Verify provenance survives unchanged.
