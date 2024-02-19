const std = @import("std");
const math = std.math;

pub const Vector2 = @import("Vector2.zig");
pub const Vector2i = @import("Vector2i.zig");
pub const Vector3 = @import("Vector3.zig");

pub fn cubicLerp(from: f64, to: f64, pre: f64, post: f64, weight: f64) f64 {
    return 0.5 * ((from * 2.0) +
        (-pre + to) * weight +
        (2.0 * pre - 5.0 * from + 4.0 * to - post) * (weight * weight) +
        (-pre + 3.0 * from - 3.0 * to + post) * (weight * weight * weight));
}
