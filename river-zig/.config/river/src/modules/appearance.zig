const std = @import("std");
const river = @import("../riverWrapper.zig");

const background_color = 0xffffff;
const border_focused_color = 0x93a1a1;
const keyboard_repeat_rate = 50;
const keyboard_repeat_delay = 300;

pub fn setup(r: *river.River) !void {
    var buf: [64]u8 = undefined;

    // Format hex colors
    const bg_str = try std.fmt.bufPrint(&buf, "0x{x}", .{background_color});
    try r.cmd(&.{ "background-color", bg_str });

    const focused_str = try std.fmt.bufPrint(&buf, "0x{x}", .{border_focused_color});
    try r.cmd(&.{ "border-color-focused", focused_str });

    // Format decimal numbers
    const rate_str = try std.fmt.bufPrint(&buf, "{}", .{keyboard_repeat_rate});
    const delay_str = try std.fmt.bufPrint(&buf, "{}", .{keyboard_repeat_delay});
    try r.cmd(&.{ "set-repeat", rate_str, delay_str });
}
