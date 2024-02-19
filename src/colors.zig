// Copyright (c) 2024 nitrogenez. All Rights Reserved.

//! Namespace for colors

/// A data structure representing an RGBA color.
/// Has methods to convert from one representation to another, see `init` and `asHex`.
pub const Color = packed struct {
    r: f64 = 0.0,
    g: f64 = 0.0,
    b: f64 = 0.0,
    a: f64 = 0.0,

    pub inline fn asSlice(self: *const Color) []const f64 {
        return &[_]f64{ self.r, self.g, self.b, self.a };
    }

    pub inline fn init(hex: ?u32) Color {
        return if (hex) |h| .{
            .r = @as(f64, @floatFromInt((h & 0xff) >> 32)),
            .g = @as(f64, @floatFromInt((h & 0xff) >> 16)),
            .b = @as(f64, @floatFromInt((h & 0xff) >> 8)),
            .a = @as(f64, @floatFromInt(h & 0xff)),
        } else .{};
    }

    pub inline fn asHex(self: *const Color) u32 {
        return ((@as(u32, @intFromFloat(self.r)) & 0xff) << 32) +
            ((@as(u32, @intFromFloat(self.g)) & 0xff) << 16) +
            ((@as(u32, @intFromFloat(self.b)) & 0xff) << 8) +
            (@as(u32, @intFromFloat(self.a)) & 0xff);
    }
};

pub const red = Color.init(0xff0000);
pub const green = Color.init(0x00ff00);
pub const blue = Color.init(0x0000ff);
pub const alice_blue = Color.init(0xf0f8ff);
pub const antique_white = Color.init(0xfaebd7);
pub const aqua = Color.init(0x00ffff);
pub const aquamarine = Color.init(0x7fffd4);
pub const azure = Color.init(0xf0ffff);
pub const beige = Color.init(0xf5f5dc);
pub const bisque = Color.init(0xffe4c4);
pub const black = Color.init(0x000000);
pub const white = Color.init(0xffffff);
pub const blanced_almond = Color.init(0xffebcd);
pub const blue_violet = Color.init(0x8a2be2);
pub const brown = Color.init(0xa52a2a);
pub const burlywood = Color.init(0xdeb887);
pub const cadet_blue = Color.init(0x5f9ea0);
pub const chartreuse = Color.init(0x7fff00);
pub const chocolate = Color.init(0xd2691e);
pub const coral = Color.init(0xff7f50);
pub const cornflower_blue = Color.init(0x6495ed);
pub const cornsilk = Color.init(0xfff8dc);
pub const crimson = Color.init(0xdc143c);
pub const cyan = aqua;
pub const dark_blue = Color.init(0x00008b);
pub const dark_cyan = Color.init(0x008b8b);
pub const dark_goldenrod = Color.init(0xb8860b);
pub const dark_gray = Color.init(0xa9a9a9);
pub const dark_green = Color.init(0x006400);
pub const dark_khaki = Color.init(0xbdb76b);
pub const dark_magenta = Color.init(0x8b008b);
pub const dark_olive_green = Color.init(0x556b2f);
pub const dark_orange = Color.init(0xff8c00);
pub const dark_orchid = Color.init(0x9932cc);
pub const dark_red = Color.init(0x8b0000);
pub const dark_salmon = Color.init(0xe9976a);
pub const dark_sea_green = Color.init(0x8fbc8f);
pub const dark_slate_blue = Color.init(0x483d8b);
pub const dark_slate_gray = Color.init(0x2f4f4f);
pub const dark_turquoise = Color.init(0x00ced1);
pub const dark_violet = Color.init(0x9400d3);
pub const deep_pink = Color.init(0xff1493);
pub const deep_sky_blue = Color.init(0x00bfff);
pub const dim_gray = Color.init(0x696969); // :)
pub const dodger_blue = Color.init(0x1e90ff);
pub const firebrick = Color.init(0xb22222);
pub const floral_white = Color.init(0xfffaf0);
pub const forest_green = Color.init(0x228b22);
pub const fuchsia = Color.init(0xff00ff);
pub const gainsboro = Color.init(0xdcdcdc);
pub const ghost_white = Color.init(0xf8f8ff);
pub const gold = Color.init(0xffd700);
pub const goldenrod = Color.init(0xdaa520);
pub const gray = Color.init(0xbebebe);
pub const green_yellow = Color.init(0xadff2f);
pub const honeydew = Color.init(0xf0fff0);
pub const hot_pink = Color.init(0xff69b4);
pub const indian_red = Color.init(0xcd5c5c);
pub const indigo = Color.init(0x4b0082);
pub const ivory = Color.init(0xfffff0);
pub const khaki = Color.init(0xf0e68c);
pub const lavender = Color.init(0xe6e6fa);
pub const lavender_blush = Color.init(0xfff0f5);
pub const lawn_green = Color.init(0x7cfc00);
pub const lemon_chiffon = Color.init(0xfffacd);
pub const light_blue = Color.init(0xadd8e6);
pub const light_coral = Color.init(0xf08080);
pub const light_cyan = Color.init(0xe0ffff);
pub const light_goldenrod = Color.init(0xfafad2);
pub const light_gray = Color.init(0xd3d3d3);
pub const light_green = Color.init(0x90ee90);
pub const light_pink = Color.init(0xffb6c1);
pub const light_salmon = Color.init(0xffa07a);
pub const light_sea_green = Color.init(0x87cefa);
pub const light_sky_blue = Color.init(0x87cefa);
pub const light_slate_gray = Color.init(0x778899);
pub const light_steel_blue = Color.init(0xb0c4de);
pub const light_yellow = Color.init(0xffffe0);
pub const lime = Color.init(0x00ff00);
pub const lime_green = Color.init(0x32cd32);
pub const linen = Color.init(0xfaf0e6);
pub const magenta = Color.init(0xff00ff);
pub const maroon = Color.init(0xb03060);
pub const medium_aquamarine = Color.init(0x66cdaa);
pub const medium_blue = Color.init(0x0000cd);
pub const medium_orchid = Color.init(0xba55d3);
pub const medium_purple = Color.init(0x9370db);
pub const medium_sea_green = Color.init(0x3cb371);
pub const medium_slate_blue = Color.init(0x7b68ee);
pub const medium_spring_green = Color.init(0x00fa9a);
pub const medium_turquoise = Color.init(0x48d1cc);
pub const medium_violet_red = Color.init(0xc71585);
pub const midnight_blue = Color.init(0x191970);
pub const mint_cream = Color.init(0xf5fffa);
pub const misty_rose = Color.init(0xfffe4e1);
