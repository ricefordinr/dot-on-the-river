const std = @import("std");
const river = @import("../riverWrapper.zig");

pub fn setup(r: *river.River, conf: anytype) !void {
    // Set default layout
    try r.cmd(.{ "default-layout", "rivertile" });

    // Start layout manager
    const view_padding = try std.fmt.allocPrint(r.allocator, "{}", .{conf.layout.view_padding});
    defer r.allocator.free(view_padding);
    const outer_padding = try std.fmt.allocPrint(r.allocator, "{}", .{conf.layout.outer_padding});
    defer r.allocator.free(outer_padding);

    try r.start(&.{ "rivertile", "-view-padding", view_padding, "-outer-padding", outer_padding });

    // Autostart other applications
    // try r.start(&.{ "waybar" });
    // try r.start(&.{ "mako" });
}
