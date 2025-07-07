const std = @import("std");
const river = @import("../riverWrapper.zig");

pub fn setup(r: *river.River) !void {
    try r.start(&.{"exec dbus-update-activation-environment DISPLAY I3SOCK SWAYSOCK WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=river"});

    try r.start(&.{"/usr/libexec/polkit-gnome-authentication-agent-1"});
    try r.start(&.{"/home/rice/.config/river/scripts/restartPortal.sh"});
    try r.start(&.{ "foot", "--server" });
    try r.start(&.{"waybar"});
    try r.start(&.{"pipewire"});
    try r.start(&.{"pipewire-pulse"});
    // try r.start(&.{ "easyeffects", "--gapplication-service" });
    try r.start(&.{"swww-daemon"});
    try r.start(&.{"fcitx5"});
    try r.start(&.{"/home/rice/applications/discord/Discord/Discord"});

    // Config external outputs on startup
    try r.start(&.{"echo 0.77 > ~/.config/river/scripts/screenScalingInfo.txt"});
    try r.start(&.{"~/.config/river/scripts/toggleScreenScaling.sh"});
}
