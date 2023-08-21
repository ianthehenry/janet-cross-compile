A demonstration of using `zig` to cross-compile native Janet binaries.

This is not very nice! It doesn't work with native dependencies, and I'm not completely sure how to change that. It also duplicates some compilation flags from JPM, which would maybe be better as some kind of overrides instead.
