# Never ignore errors

Every catch block, every rejected promise, every error result must be handled. If the error can't be handled at this level, re-throw or propagate it.

No swallowed errors: no `catch {}`, no `.catch(() => {})`, no `try { } catch { }`.
