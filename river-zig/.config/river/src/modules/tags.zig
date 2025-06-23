const std = @import("std");
const river = @import("../riverWrapper.zig");
const keybindings = @import("keybindings.zig");

pub fn setup(r: *river.River) !void {
    const MOD = keybindings.mod_key;
    var buf: [64]u8 = undefined;

    var i: u32 = 1;
    while (i <= 9) : (i += 1) {
        const tags = std.math.pow(u32, 2, i - 1);

        // Explicitly format numbers to strings before calling `bind`.
        const i_str = try std.fmt.bufPrint(&buf, "{}", .{i});
        const tags_str = try std.fmt.bufPrint(&buf, "{}", .{tags});

        try r.bind("normal", MOD, i_str, &.{ "set-focused-tags", tags_str });
        try r.bind("normal", MOD ++ "+Shift", i_str, &.{ "set-view-tags", tags_str });
    }
}
