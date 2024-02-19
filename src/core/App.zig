const std = @import("std");
const log = std.log.scoped(.@"LumiEngine:App");

const App = @This();

/// Used to determine build mode
pub const AppKind = enum {
    None, // Unknown app kind
    App, // Standard desktop application
    Game, // Lumi game
    Tool, // CLI tool
};

name: []const u8,
about: []const u8,
long_about: []const u8,
version: ?std.SemanticVersion = null,
kind: AppKind,

/// Used to create a new Lumi application
pub fn init(
    name: ?[]const u8,
    about: ?[]const u8,
    long_about: ?[]const u8,
    version: ?std.SemanticVersion,
    kind: ?AppKind,
) App {
    return App{
        .name = name orelse "Lumi",
        .about = about orelse "Made with Lumi Engine",
        .long_about = long_about orelse "",
        .version = version,
        .kind = kind orelse .App,
    };
}
