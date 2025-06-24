const std = @import("std");
const river = @import("../riverWrapper.zig");

pub fn setup(r: *river.River) !void {
    try r.start(&.{ "foot", "--server" });
    try r.start(&.{"waybar"});
    try r.start(&.{"pipewire"});
    try r.start(&.{ "easyeffects", "--gapplication-service" });
    try r.start(&.{"swww-daemon"});
    try r.start(&.{"fcitx5"});
    try r.start(&.{"~/applications/discord/Discord/Discord"});
}
