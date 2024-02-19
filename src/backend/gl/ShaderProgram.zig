const std = @import("std");
const log = std.log.scoped(.@"lumi_engine/shaders");
const gl = @import("gl45");

id: u32,
arena: std.heap.ArenaAllocator,
shaders: std.ArrayListUnmanaged(u32) = .{},

pub const ShaderType = enum(u32) {
    vertex = 0x8b31,
    fragment = 0x8b30,
    geometry = 0x8dd9,
    compute = 0x91b9,

    pub fn serialize(self: ShaderType) []const u8 {
        return @tagName(self);
    }

    pub fn deserialize(data: []const u8) ?ShaderType {
        return inline for (@typeInfo(ShaderType).Enum.fields) |f| {
            if (std.mem.eql(u8, data, f.name))
                break @enumFromInt(f.value);
        } else null;
    }
};

pub fn init(gpa: std.mem.Allocator) @This() {
    return .{
        .id = gl.createProgram(),
        .arena = std.heap.ArenaAllocator.init(gpa),
    };
}

pub fn deinit(self: *@This()) void {
    gl.deleteProgram(self.id);
    self.arena.deinit();
    self.* = undefined;
}

pub fn use(self: *const @This()) void {
    gl.useProgram(self.id);
}

pub fn link(self: *@This()) !void {
    gl.linkProgram(self.id);

    for (self.shaders.items) |shader|
        gl.deleteShader(shader);
    self.shaders.deinit(self.arena.allocator());

    const linkres = getProgramIv(self.id, gl.LINK_STATUS);

    if (linkres.info_log) |il| {
        log.warn("shader_program: linking FAILED", .{});
        log.warn("OpenGL Log:\n{s}", .{il});
        return error.LinkFailed;
    }
}

pub fn addShader(self: *@This(), source: []const u8, kind: ShaderType) !void {
    if (source.len == 0)
        return error.EmptySource;

    const shader = gl.createShader(kind);

    gl.shaderSource(shader, 1, &[_][]const u8{source}, &[_]i32{@intCast(source.len)});
    gl.compileShader(shader);

    const compres = getShaderIv(shader, gl.COMPILE_STATUS);

    if (compres.info_log) |il| {
        log.warn("shader: compilation FAILED", .{});
        log.warn("shader type: {s}, size (bytes): {d}", .{ @tagName(kind), source.len });
        log.warn("glsl compilation log:\n{s}", .{il});
        return error.CompilationFailed;
    }
    gl.attachShader(self.id, shader);

    log.info("shader: compilation SUCCEEDED", .{});
    log.info("shader type: {s}, size (bytes): {d}", .{ @tagName(kind), source.len });
    log.info("no errors were reported during compilation", .{});

    try self.shaders.append(self.arena.allocator(), shader);
}

pub fn addShaderFile(self: *@This(), path: []const u8, kind: ShaderType) !void {
    var file = try std.fs.cwd().openFile(path, .{});
    defer file.close();

    const source = try file.reader().readAllAlloc(self.arena.allocator(), 2 * 1024 * 1024);
    defer self.arena.allocator().free(source);

    log.info("shader: loading from file, path: {s}", .{path});

    self.addShader(source, kind) catch |err| {
        log.warn("shader: loading from file FAILED: {s}", .{@errorName(err)});
        return err;
    };
    log.info("shader: loading from file SUCCEEDED", .{});
}

const ShaderInfo = struct {
    result: u32 = 1,
    info_log: ?[512]u8 = null,
};

const ProgramInfo = struct {
    result: u32 = 1,
    info_log: ?[512]u8 = null,
};

fn getShaderIv(shader: c_uint, what: c_uint) ShaderInfo {
    var out: ShaderInfo = .{};
    gl.getShaderIv(shader, what, &out.result);

    if (out.result == 0)
        gl.getShaderInfoLog(shader, 512, 0, &out.info_log);
    return out;
}

fn getProgramIv(program: c_uint, what: c_uint) ProgramInfo {
    var out: ProgramInfo = .{};
    gl.getProgramiv(program, what, &out.result);

    if (out.result == 0)
        gl.getProgramInfoLog(program, 512, 0, &out.info_log);
    return out;
}
