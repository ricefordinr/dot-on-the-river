const std = @import("std");
const river = @import("../riverWrapper.zig");

pub fn setup(r: *river.River, conf: anytype) !void {
    const MOD = conf.mod_key;
    var i: u32 = 1;
    while (i <= 9) : (i += 1) {
        const tags = std.math.pow(u32, 2, i - 1);

        const i_str = try std.fmt.allocPrint(r.allocator, "{}", .{i});
        defer r.allocator.free(i_str);
        const tags_str = try std.fmt.allocPrint(r.allocator, "{}", .{tags});
        defer r.allocator.free(tags_str);

        try r.bind("normal", MOD, i_str, .{ "set-focused-tags", tags_str });
        try r.bind("normal", MOD ++ "+Shift", i_str, .{ "set-view-tags", tags_str });
    }
}
