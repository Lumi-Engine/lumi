const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const mach_glfw_dep = b.dependency("mach_glfw", .{ .optimize = optimize, .target = target });

    const lumi_imports: []const std.Build.Module.Import = &.{
        .{ .name = "mach-glfw", .module = mach_glfw_dep.module("mach-glfw") },
    };

    _ = b.addModule("lumi", .{
        .root_source_file = .{ .path = "src/root.zig" },
        .imports = lumi_imports,
    });

    const lib = b.addStaticLibrary(.{
        .name = "lumi",
        .root_source_file = .{ .path = "src/root.zig" },
        .target = target,
        .optimize = optimize,
    });
    b.installArtifact(lib);

    for (lumi_imports) |import| lib.root_module.addImport(import.name, import.module);

    const lib_unit_tests = b.addTest(.{
        .root_source_file = .{ .path = "src/root.zig" },
        .target = target,
        .optimize = optimize,
    });
    const run_lib_unit_tests = b.addRunArtifact(lib_unit_tests);
    const test_step = b.step("test", "Run unit tests");
    test_step.dependOn(&run_lib_unit_tests.step);

    const install_docs = b.addInstallDirectory(.{
        .source_dir = lib.getEmittedDocs(),
        .install_dir = .prefix,
        .install_subdir = "doc",
    });
    const docs_step = b.step("docs", "Emit and install Lumi documentation");
    docs_step.dependOn(&install_docs.step);
}
