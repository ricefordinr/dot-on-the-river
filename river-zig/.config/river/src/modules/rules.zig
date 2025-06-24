const std = @import("std");
const river = @import("../riverWrapper.zig");

pub fn setup(r: *river.River) !void {
    try r.rule("ssd", .{});

    //Use `lswt` to get app-id and title

    //Riverctl does not support regex lmao
    //Make Picture in Picture floats
    try r.rule("float", .{ .title = "*Picture-in-Picture*" });
    try r.rule("float", .{ .title = "*picture-in-picture*" });
    try r.rule("float", .{ .title = "*Picture in Picture*" });
    try r.rule("float", .{ .title = "*picture in picture*" });

    try r.rule("float", .{ .id = "*pavucontrol*" });

    try r.rule("tags", .{ .id = "discord", .arg = "32" });
}
