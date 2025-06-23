const std = @import("std");
const river = @import("../riverWrapper.zig");

pub fn setup(r: *river.River, conf: anytype) !void {
    const bg_str = try std.fmt.allocPrint(r.allocator, "0x{x}", .{conf.appearance.background_color});
    defer r.allocator.free(bg_str);
    const focused_str = try std.fmt.allocPrint(r.allocator, "0x{x}", .{conf.appearance.border_focused_color});
    defer r.allocator.free(focused_str);
    const unfocused_str = try std.fmt.allocPrint(r.allocator, "0x{x}", .{conf.appearance.border_unfocused_color});
    defer r.allocator.free(unfocused_str);

    try r.cmd(.{ "background-color", bg_str });
    try r.cmd(.{ "border-color-focused", focused_str });
    try r.cmd(.{ "border-color-unfocused", unfocused_str });

    const rate_str = try std.fmt.allocPrint(r.allocator, "{}", .{conf.keyboard.repeat_rate});
    defer r.allocator.free(rate_str);
    const delay_str = try std.fmt.allocPrint(r.allocator, "{}", .{conf.keyboard.repeat_delay});
    defer r.allocator.free(delay_str);

    try r.cmd(.{ "set-repeat", rate_str, delay_str });
}
