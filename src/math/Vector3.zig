const std = @import("std");
const math = std.math;

const Vector3 = @This();

x: f64 = 0.0,
y: f64 = 0.0,
z: f64 = 0.0,

pub fn magnitude(self: Vector3) f64 {
    return @sqrt(self.x * self.x + self.y * self.y + self.z * self.z);
}

pub fn magnitude2(self: Vector3) f64 {
    return self.x * self.x + self.y * self.y + self.z * self.z;
}

pub fn normalized(self: Vector3) Vector3 {
    const mag: f64 = self.magnitude();
    const mag2: f64 = self.magnitude2();

    return if (mag2 == 0.0) Vector3{} else Vector3{
        .x = self.x / mag,
        .y = self.y / mag,
        .z = self.z / mag,
    };
}

pub fn abs(self: Vector3) Vector3 {
    return Vector3{
        .x = math.fabs(self.x),
        .y = math.fabs(self.y),
        .z = math.fabs(self.z),
    };
}

pub fn ceil(self: Vector3) Vector3 {
    return Vector3{
        .x = @ceil(self.x),
        .y = @ceil(self.y),
        .z = @ceil(self.z),
    };
}

pub fn clamp(self: Vector3, min: Vector3, max: Vector3) Vector3 {
    return Vector3{
        .x = math.clamp(self.x, min.x, max.x),
        .y = math.clamp(self.y, min.y, max.y),
        .z = math.clamp(self.z, min.z, max.z),
    };
}

pub fn cross(self: Vector3, other: Vector3) Vector3 {
    return Vector3{
        .x = (self.y * other.z) - (self.z * other.y),
        .y = (self.z * other.x) - (self.x * other.z),
        .z = (self.x * other.y) - (self.y * other.x),
    };
}

pub fn dirTo(self: Vector3, target: Vector3) Vector3 {
    return (Vector3{
        .x = target.x - self.x,
        .y = target.y - self.y,
        .z = target.z - self.z,
    }).normalized();
}

pub fn distance2(self: Vector3, target: Vector3) f64 {
    _ = target;
    _ = self;
    return 0; // (target.sub(self)).magnitude2();
}

pub fn distance(self: Vector3, target: Vector3) f64 {
    _ = target;
    _ = self;
    return 0; // (target.sub(self)).magnitude();
}

pub fn dot(self: Vector3, other: Vector3) f64 {
    return self.x * other.x + self.y * other.y + self.z * other.z;
}

pub fn floor(self: Vector3) Vector3 {
    return Vector3{
        .x = @floor(self.x),
        .y = @floor(self.y),
        .z = @floor(self.z),
    };
}

pub fn negated(self: Vector3) Vector3 {
    return Vector3{
        .x = -self.x,
        .y = -self.y,
        .z = -self.z,
    };
}

pub fn isFinite(self: Vector3) bool {
    return math.isFinite(self.x) and math.isFinite(self.y) and math.isFinite(self.z);
}

pub fn isNormalized(self: Vector3) bool {
    return math.fabs(self.magnitude2() - 1.0) < math.epsilon;
}

pub fn lerp(self: Vector3, target: Vector3, weight: f64) Vector3 {
    return Vector3{
        .x = math.lerp(self.x, target.x, weight),
        .y = math.lerp(self.y, target.y, weight),
        .z = math.lerp(self.z, target.z, weight),
    };
}

pub fn moveTowards(self: Vector3, target: Vector3, delta: f64) Vector3 {
    var v1: Vector3 = self;
    var vd: Vector3 = target.sub(v1);
    const mag: f64 = vd.magnitude();

    if (mag <= delta or mag < math.epsilon) {
        return target;
    }
    return v1.add(vd.divScalar(mag * delta));
}

/// Returns an addition product of `self` and `other` values
pub fn add(self: Vector3, other: Vector3) Vector3 {
    return Vector3{
        .x = self.x + other.x,
        .y = self.y + other.y,
        .z = self.z + other.z,
    };
}

/// Returns a subtraction product of `self` and `other` values
pub fn sub(self: Vector3, other: Vector3) Vector3 {
    return Vector3{
        .x = self.x - other.x,
        .y = self.y - other.y,
        .z = self.z - other.z,
    };
}

/// Returns a multiplication product of `self` and `other` values
pub fn mul(self: Vector3, other: Vector3) Vector3 {
    return Vector3{
        .x = self.x * other.x,
        .y = self.y * other.y,
        .z = self.z * other.z,
    };
}

/// Returns a division product of `self` and `other` values
pub fn div(self: Vector3, other: Vector3) Vector3 {
    return Vector3{
        .x = self.x / other.x,
        .y = self.y / other.y,
        .z = self.z / other.z,
    };
}

/// Returns a modulo of `self` and `other` values
pub fn mod(self: Vector3, other: Vector3) Vector3 {
    return Vector3{
        .x = self.x % other.x,
        .y = self.y % other.y,
        .z = self.z % other.z,
    };
}

/// Compares `self` and `other` by exact similarity
pub fn eql(self: Vector3, other: Vector3) bool {
    return self.x == other.x and self.y == other.y and self.z == other.z;
}

/// Returns an addition product of `self` values and a scalar `value`
pub fn addScalar(self: Vector3, value: f64) Vector3 {
    return Vector3{
        .x = self.x + value,
        .y = self.y + value,
        .z = self.z + value,
    };
}

/// Returns a subtraction product of `self` values and a scalar `value`
pub fn subScalar(self: Vector3, value: f64) Vector3 {
    return Vector3{
        .x = self.x - value,
        .y = self.y - value,
        .z = self.z - value,
    };
}

/// Returns a multiplication product of `self` values and a scalar `value`
pub fn mulScalar(self: Vector3, value: f64) Vector3 {
    return Vector3{
        .x = self.x * value,
        .y = self.y * value,
        .z = self.z * value,
    };
}

/// Returns a division product of `self` values and a scalar `value`
pub fn divScalar(self: Vector3, value: f64) Vector3 {
    return Vector3{
        .x = self.x / value,
        .y = self.y / value,
        .z = self.z / value,
    };
}

/// Returns a modulo of `self` values and a scalar `value`
pub fn modScalar(self: Vector3, value: f64) Vector3 {
    return Vector3{
        .x = self.x % value,
        .y = self.y % value,
        .z = self.z % value,
    };
}

/// Compares each `self` value to a scalar `value`
pub fn eqlScalar(self: Vector3, value: f64) bool {
    return self.x == value and self.y == value and self.z == value;
}

/// Returns a Zig vector `@Vector(3, f64)` made from `self`
pub fn asZigVector(self: Vector3) @Vector(3, f64) {
    return @Vector(3, f64){ self.x, self.y, self.z };
}

/// Returns a slice of `f64` `{ X, Y }`
pub fn asSlice(self: Vector3) [3]f64 {
    return [3]f64{ self.x, self.y, self.z };
}
