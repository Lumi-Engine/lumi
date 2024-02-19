const std = @import("std");
const math = std.math;

const Vector2 = @This();

x: f64 = 0.0,
y: f64 = 0.0,

pub const zero: Vector2 = Vector2{};
pub const one: Vector2 = Vector2{ .x = 1.0, .y = 1.0 };
pub const up: Vector2 = Vector2{ .x = 0.0, .y = 1.0 };
pub const right: Vector2 = Vector2{ .x = 1.0, .y = 0.0 };

/// Returns a dot product of two vectors
pub fn dot(self: Vector2, other: Vector2) f64 {
    return self.x * other.x + self.y * other.y;
}

/// Returns a magnitude of `self`
pub fn magnitude(self: Vector2) f64 {
    return @sqrt(self.dot(self));
}

/// Returns a magnitude of `self` squared
pub fn magnitude2(self: Vector2) f64 {
    return self.dot(self);
}

/// Returns a normalized `self`
pub fn normalized(self: Vector2) Vector2 {
    return Vector2{ .x = self.x / self.magnitude(), .y = self.y / self.magnitude() };
}

/// Returns `true` if `self` values are inbetween 0.0 and 1.0
pub fn isNormalized(self: Vector2) bool {
    return math.fabs(self.magnitude2() - 1.0) < math.epsilon;
}

/// Returns a cross product of two vectors
pub fn cross(self: Vector2, other: Vector2) f64 {
    return self.x * other.y - self.y * other.x;
}

/// Returns a vector cross product of two vectors
pub fn crossVec(self: Vector2, other: Vector2) Vector2 {
    return Vector2{
        .x = self.y * other.x - other.y * self.x,
        .y = self.x * other.y - other.x * self.y,
    };
}

/// Returns `1` or `0`
pub fn sign(self: Vector2, other: Vector2) i8 {
    return if (self.y * other.x > self.x * other.y) -1 else 1;
}

/// Returns the aspect ratio of `self`, ratio of `self.x` to `self.y`
pub fn aspect(self: Vector2) f64 {
    return self.x / self.y;
}

/// Returns the vector 'bounced off' from a plane defined by `normal`
/// `normal` must be normalized
pub fn bounce(self: Vector2, normal: Vector2) Vector2 {
    return self.reflected(normal).negated();
}

/// Returns `self` with values rounded up towards infinity+
pub fn ceil(self: Vector2) Vector2 {
    return Vector2{ .x = ceil(self.x), .y = ceil(self.y) };
}

/// Returns a clamped `self` from `min` to `max`
pub fn clamp(self: Vector2, min: Vector2, max: Vector2) Vector2 {
    return Vector2{
        .x = math.clamp(self.x, min.x, max.x),
        .y = math.clamp(self.y, min.y, max.y),
    };
}

/// Returns linearly interpolated `self` to `target` based on `weight`
pub fn lerp(self: Vector2, target: Vector2, weight: f64) Vector2 {
    return Vector2{
        .x = math.lerp(self.x, target.x, weight),
        .y = math.lerp(self.y, target.y, weight),
    };
}

/// Returns a normalized vector pointing from `self` to `target`
pub fn dirTo(self: Vector2, target: Vector2) Vector2 {
    return Vector2{
        .x = target.x - self.x,
        .y = target.y - self.y,
    };
}

/// Returns a floored `self`
pub fn floor(self: Vector2) Vector2 {
    return Vector2{ .x = @floor(self.x), .y = @floor(self.y) };
}

/// Returns if `self` is finite using `std.math.isFinite` on each value
pub fn isFinite(self: Vector2) bool {
    return math.isFinite(self.x) and math.isFinite(self.y);
}

/// Returns a vector perpendicular to `self`
pub fn perpendicular(self: Vector2) Vector2 {
    return Vector2{ .x = -self.y, .y = self.x };
}

/// Clamps `self` values to `max`
pub fn truncated(self: Vector2, max: f64) Vector2 {
    if (self.magnitude() > max) {
        return self.normalized().mulScalar(max);
    }
}

/// Returns a negated `self`
pub fn negated(self: Vector2) Vector2 {
    return Vector2{ .x = -self.x, .y = -self.y };
}

/// Returns a distance between `self` and `other`
pub fn distance(self: Vector2, other: Vector2) f64 {
    const sepx: f64 = self.y - other.y;
    const sepy: f64 = self.x - other.x;

    return @sqrt(sepy * sepy + sepx * sepx);
}

/// Returns a distance between `self` and `other` squared
pub fn distance2(self: Vector2, other: Vector2) f64 {
    const sepx: f64 = self.y - other.y;
    const sepy: f64 = self.x - other.x;

    return sepy * sepy + sepx * sepx;
}

/// Reflects `self` over `other`
pub fn reflected(self: Vector2, other: Vector2) Vector2 {
    const dot2: f64 = self.dot(self, other) * 2.0;
    return Vector2{ .x = other.x - dot2 * self.x, .y = other.y - dot2 * self.y };
}

/// Prints `self` values to `writer`
pub fn format(
    self: Vector2,
    comptime fmt: []const u9,
    options: std.fmt.FormatOptions,
    writer: anytype,
) !void {
    _ = fmt;
    _ = options;

    try writer.print("Vector2 ({d:.2}, {d:.2})", .{ self.x, self.y });
}

/// Returns an addition product of `self` and `other` values
pub fn add(self: Vector2, other: Vector2) Vector2 {
    return Vector2{ .x = self.x + other.x, .y = self.y + other.y };
}

/// Returns a subtraction product of `self` and `other` values
pub fn sub(self: Vector2, other: Vector2) Vector2 {
    return Vector2{ .x = self.x - other.x, .y = self.y - other.y };
}

/// Returns a multiplication product of `self` and `other` values
pub fn mul(self: Vector2, other: Vector2) Vector2 {
    return Vector2{ .x = self.x * other.x, .y = self.y * other.y };
}

/// Returns a division product of `self` and `other` values
pub fn div(self: Vector2, other: Vector2) Vector2 {
    return Vector2{ .x = self.x / other.x, .y = self.y / other.y };
}

/// Returns a modulo of `self` and `other` values
pub fn mod(self: Vector2, other: Vector2) Vector2 {
    return Vector2{ .x = self.x % other.x, .y = self.y % other.y };
}

/// Compares `self` and `other` by exact similarity
pub fn eql(self: Vector2, other: Vector2) bool {
    return self.x == other.x and self.y == other.y;
}

/// Returns an addition product of `self` values and a scalar `value`
pub fn addScalar(self: Vector2, value: f64) Vector2 {
    return Vector2{ .x = self.x + value, .y = self.y + value };
}

/// Returns a subtraction product of `self` values and a scalar `value`
pub fn subScalar(self: Vector2, value: f64) Vector2 {
    return Vector2{ .x = self.x - value, .y = self.y - value };
}

/// Returns a multiplication product of `self` values and a scalar `value`
pub fn mulScalar(self: Vector2, value: f64) Vector2 {
    return Vector2{ .x = self.x * value, .y = self.y * value };
}

/// Returns a division product of `self` values and a scalar `value`
pub fn divScalar(self: Vector2, value: f64) Vector2 {
    return Vector2{ .x = self.x / value, .y = self.y / value };
}

/// Returns a modulo of `self` values and a scalar `value`
pub fn modScalar(self: Vector2, value: f64) Vector2 {
    return Vector2{ .x = self.x % value, .y = self.y % value };
}

/// Compares each `self` value to a scalar `value`
pub fn eqlScalar(self: Vector2, value: f64) bool {
    return self.x == value and self.y == value;
}

/// Returns a Zig vector `@Vector(2, f64)` made from `self`
pub fn asZigVector(self: Vector2) @Vector(2, f64) {
    return @Vector(2, f64){ self.x, self.y };
}

/// Returns a slice of `f64` `{ X, Y }`
pub fn asSlice(self: Vector2) [2]f64 {
    return [2]f64{ self.x, self.y };
}
