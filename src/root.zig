const std = @import("std");

test {
    _ = math;
}

/// Scoped log for lumi
pub const log = std.log.scoped(.@"lumi_engine/global");

/// Math namespace
pub const math = @import("math/math.zig");
