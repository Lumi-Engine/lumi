const std = @import("std");

test {
    _ = math;
    _ = App;
}

/// Application data structure for Lumi applications
pub const App = @import("core/App.zig");

/// Scoped log for lumi
pub const log = std.log.scoped(.@"lumi_engine/global");

/// Math namespace
pub const math = @import("math/math.zig");

/// Color namespace
pub const colors = @import("colors.zig");
