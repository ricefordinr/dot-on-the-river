const std = @import("std");
const river = @import("../riverWrapper.zig");

const keyboard_repeat_rate = 50;
const keyboard_repeat_delay = 300;

pub fn setup(r: *river.River) !void {
    var buf: [64]u8 = undefined;

    const rate_str = try std.fmt.bufPrint(&buf, "{}", .{keyboard_repeat_rate});
    const delay_str = try std.fmt.bufPrint(&buf, "{}", .{keyboard_repeat_delay});
    try r.cmd(&.{ "set-repeat", rate_str, delay_str });
}
