const std = @import("std");
const river = @import("../riverWrapper.zig");

pub fn setup(r: *river.River) !void {

    // Format hex colors
    try r.cmd(&.{ "background-color", "0xffffff" });
    try r.cmd(&.{ "border-color-focused", "0xffffff" });
    try r.cmd(&.{ "border-color-unfocused", "0xbbbbbb" });
    try r.cmd(&.{ "border-color-urgent", "0x770000" });

    try r.cmd(&.{ "border-width", "4" });
}
