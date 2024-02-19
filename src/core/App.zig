// Copyright (c) 2024 nitrogenez. All Rights Reserved.

//! This is a data structure representing a Lumi application.

const std = @import("std");
const log = std.log.scoped(.@"lumi_engine/application");

/// Used to determine build mode
pub const AppType = enum {
    /// Standard desktop application using Lumi's capabilities
    app,
    /// A 2D/3D game using Lumi capabilities
    game,
    /// A CLI tool using Lumi framework, e.g math library
    cli_tool,

    pub fn serialize(self: AppType) []const u8 {
        return @tagName(self);
    }

    pub fn deserialize(data: []const u8) ?AppType {
        return inline for (@typeInfo(AppType).Enum.fields) |f| {
            if (std.mem.eql(u8, data, f.name))
                break @enumFromInt(f.value);
        } else null;
    }
};

pub const AppData = struct {
    /// Application name that is used for, e.g, window title
    name: []const u8,
    /// Quick application description (or summary)
    about: ?[]const u8,
    /// A detailed application description
    long_about: ?[]const u8,
    /// An optional applicaton version, can be displayed in the title
    version: ?std.SemanticVersion = null,
    /// Application type
    type: AppType,
};

arena: std.heap.ArenaAllocator,
data: AppData,

/// Used to create a new Lumi application
pub fn init(gpa: std.mem.Allocator, data: AppData) @This() {
    return .{
        .arena = std.heap.ArenaAllocator.init(gpa),
        .data = data,
    };
}

/// Returns a window title based off the name and version if `with_version` is true.
/// `deinit` should be called to free the allocated memory.
pub fn getTitle(self: *const @This(), with_version: bool) ![]const u8 {
    if (with_version and self.data.version != null)
        return try std.fmt.allocPrint(self.arena.allocator(), "{s} {}", .{ self.data.name, self.data.version.? });
    return try self.arena.allocator().dupe(u8, self.data.name);
}

/// Turns the application data into a JSON string.
/// `deinit` should be called to free the allocated memory.
pub fn serialize(self: *const @This()) []const u8 {
    return std.json.stringifyAlloc(self.arena.allocator(), self.data, .{});
}

/// Frees allocated resources and dereferences self.
pub fn deinit(self: *@This()) void {
    self.arena.deinit();
    self.* = undefined;
}
