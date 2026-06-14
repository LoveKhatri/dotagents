# Validate at boundaries

Input validation belongs at system boundaries: API handlers, CLI inputs, form submissions, database writes. Internal functions should trust their callers — don't re-validate everywhere.
