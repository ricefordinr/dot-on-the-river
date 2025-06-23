const std = @import("std");
const river = @import("../riverWrapper.zig");

const view_padding = 6;
const outer_padding = 6;

pub fn setup(r: *river.River) !void {
    try r.cmd(&.{ "default-layout", "rivertile" });

    var buf: [16]u8 = undefined;
    const view_padding_str = try std.fmt.bufPrint(&buf, "{}", .{view_padding});
    const outer_padding_str = try std.fmt.bufPrint(&buf, "{}", .{outer_padding});

    try r.start(&.{ "rivertile", "-view-padding", view_padding_str, "-outer-padding", outer_padding_str });
}
