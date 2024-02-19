const std = @import("std");
const builtin = @import("builtin");

pub const BackendType = enum {
    gl,
    gles,
    d3d,
    metal,
    vulkan,
};

pub const default_backend: BackendType = switch (builtin.os.tag) {
    .windows => .d3d,
    .linux, .openbsd, .freebsd, .dragonfly, .netbsd => .gl,
    .macos => .metal,
    else => blk: {
        @compileLog("warning: os '" ++ @tagName(builtin.os.tag) ++ "' is not supported, defauling to OpenGL");
        break :blk .gl;
    },
};

pub fn deduceBackend() BackendType {}
