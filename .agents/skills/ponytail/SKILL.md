---
name: ponytail
description: Choose the simplest correct solution and remove unnecessary complexity.
user-invocable: true
---

# Ponytail

Use this skill during planning, implementation, and review.

1. Does this need to be built at all?
2. Does the codebase already have the helper or pattern?
3. Does the standard library or native platform solve it?
4. Does an installed dependency already solve it?
5. Can the change be one line or fewer files?
6. Only then write the minimum code that works.

Understand the real flow before simplifying. Fix shared root causes instead of symptoms. Prefer deletion over addition, avoid speculative abstractions and dependencies, and choose edge-case-correct standard-library solutions.

Do not simplify away input validation, error handling that prevents data loss, security, accessibility, or required behavior. Non-trivial logic leaves one runnable check. Mark deliberate shortcuts with a `ponytail:` comment that names the known ceiling and upgrade path.
