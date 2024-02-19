const std = @import("std");
const math = std.math;

const Vector2i = @This();

x: i32 = 0,
y: i32 = 0,

pub const zero: Vector2i = Vector2i{};
pub const one: Vector2i = Vector2i{ .x = 1, .y = 1 };
pub const up: Vector2i = Vector2i{ .x = 0, .y = 1 };
pub const right: Vector2i = Vector2i{ .x = 1, .y = 0 };

/// Returns a dot product of two vectors
pub fn dot(self: Vector2i, other: Vector2i) i32 {
    return self.x * other.x + self.y * other.y;
}

/// Returns a magnitude of `self`
pub fn magnitude(self: Vector2i) i32 {
    return @sqrt(self.dot(self));
}

/// Returns a magnitude of `self` squared
pub fn magnitude2(self: Vector2i) i32 {
    return self.dot(self);
}

/// Returns a cross product of two vectors
pub fn cross(self: Vector2i, other: Vector2i) i32 {
    return self.x * other.y - self.y * other.x;
}

/// Returns a vector cross product of two vectors
pub fn crossVec(self: Vector2i, other: Vector2i) Vector2i {
    return Vector2i{
        .x = self.y * other.x - other.y * self.x,
        .y = self.x * other.y - other.x * self.y,
    };
}

/// Returns `1` or `0`
pub fn sign(self: Vector2i, other: Vector2i) i8 {
    return if (self.y * other.x > self.x * other.y) -1 else 1;
}

/// Returns the aspect ratio of `self`, ratio of `self.x` to `self.y`
pub fn aspect(self: Vector2i) i32 {
    return self.x / self.y;
}

/// Returns the vector 'bounced off' from a plane defined by `normal`
/// `normal` must be normalized
pub fn bounce(self: Vector2i, normal: Vector2i) Vector2i {
    return self.reflected(normal).negated();
}

/// Returns `self` with values rounded up towards infinity+
pub fn ceil(self: Vector2i) Vector2i {
    return Vector2i{ .x = @ceil(self.x), .y = @ceil(self.y) };
}

/// Returns a clamped `self` from `min` to `max`
pub fn clamp(self: Vector2i, min: Vector2i, max: Vector2i) Vector2i {
    return Vector2i{
        .x = math.clamp(self.x, min.x, max.x),
        .y = math.clamp(self.y, min.y, max.y),
    };
}

/// Returns a normalized vector pointing from `self` to `target`
pub fn dirTo(self: Vector2i, target: Vector2i) Vector2i {
    return Vector2i{
        .x = target.x - self.x,
        .y = target.y - self.y,
    };
}

/// Returns a vector perpendicular to `self`
pub fn perpendicular(self: Vector2i) Vector2i {
    return Vector2i{ .x = -self.y, .y = self.x };
}

/// Clamps `self` values to `max`
pub fn truncated(self: Vector2i, max: f64) Vector2i {
    if (self.magnitude() > max) {
        return self.normalized().mulScalar(max);
    }
}

/// Returns a negated `self`
pub fn negated(self: Vector2i) Vector2i {
    return Vector2i{ .x = -self.x, .y = -self.y };
}

/// Returns a distance between `self` and `other`
pub fn distance(self: Vector2i, other: Vector2i) i32 {
    const sepx: i32 = self.y - other.y;
    const sepy: i32 = self.x - other.x;

    return @sqrt(sepy * sepy + sepx * sepx);
}

/// Returns a distance between `self` and `other` squared
pub fn distance2(self: Vector2i, other: Vector2i) i32 {
    const sepx: i32 = self.y - other.y;
    const sepy: i32 = self.x - other.x;

    return sepy * sepy + sepx * sepx;
}

/// Reflects `self` over `other`
pub fn reflected(self: Vector2i, other: Vector2i) Vector2i {
    const dot2: i32 = self.dot(self, other) * 2;
    return Vector2i{ .x = other.x - dot2 * self.x, .y = other.y - dot2 * self.y };
}

/// Prints `self` values to `writer`
pub fn format(
    self: Vector2i,
    comptime fmt: []const u9,
    options: std.fmt.FormatOptions,
    writer: anytype,
) !void {
    _ = fmt;
    _ = options;

    try writer.print("Vector2i ({d}, {d})", .{ self.x, self.y });
}

/// Returns an addition product of `self` and `other` values
pub fn add(self: Vector2i, other: Vector2i) Vector2i {
    return Vector2i{ .x = self.x + other.x, .y = self.y + other.y };
}

/// Returns a subtraction product of `self` and `other` values
pub fn sub(self: Vector2i, other: Vector2i) Vector2i {
    return Vector2i{ .x = self.x - other.x, .y = self.y - other.y };
}

/// Returns a multiplication product of `self` and `other` values
pub fn mul(self: Vector2i, other: Vector2i) Vector2i {
    return Vector2i{ .x = self.x * other.x, .y = self.y * other.y };
}

/// Returns a division product of `self` and `other` values
pub fn div(self: Vector2i, other: Vector2i) Vector2i {
    return Vector2i{ .x = self.x / other.x, .y = self.y / other.y };
}

/// Returns a modulo of `self` and `other` values
pub fn mod(self: Vector2i, other: Vector2i) Vector2i {
    return Vector2i{ .x = self.x % other.x, .y = self.y % other.y };
}

/// Compares `self` and `other` by exact similarity
pub fn eql(self: Vector2i, other: Vector2i) bool {
    return self.x == other.x and self.y == other.y;
}

/// Returns an addition product of `self` values and a scalar `value`
pub fn addScalar(self: Vector2i, value: i32) Vector2i {
    return Vector2i{ .x = self.x + value, .y = self.y + value };
}

/// Returns a subtraction product of `self` values and a scalar `value`
pub fn subScalar(self: Vector2i, value: i32) Vector2i {
    return Vector2i{ .x = self.x - value, .y = self.y - value };
}

/// Returns a multiplication product of `self` values and a scalar `value`
pub fn mulScalar(self: Vector2i, value: i32) Vector2i {
    return Vector2i{ .x = self.x * value, .y = self.y * value };
}

/// Returns a division product of `self` values and a scalar `value`
pub fn divScalar(self: Vector2i, value: i32) Vector2i {
    return Vector2i{ .x = self.x / value, .y = self.y / value };
}

/// Returns a modulo of `self` values and a scalar `value`
pub fn modScalar(self: Vector2i, value: i32) Vector2i {
    return Vector2i{ .x = self.x % value, .y = self.y % value };
}

/// Compares each `self` value to a scalar `value`
pub fn eqlScalar(self: Vector2i, value: i32) bool {
    return self.x == value and self.y == value;
}

/// Returns a Zig vector `@Vector(2, i32)` made from `self`
pub fn asZigVector(self: Vector2i) @Vector(2, i32) {
    return @Vector(2, i32){ self.x, self.y };
}

/// Returns a slice of `i32` `{ X, Y }`
pub fn asSlice(self: Vector2i) [2]i32 {
    return [3]i32{ self.x, self.y };
}
