const std = @import("std");
const river = @import("../riverWrapper.zig");

pub const mod_key = "Super";
const terminal = "footclient";
const fallback_terminal = "foot";
const launcher = "fuzzel";

pub fn setup(r: *river.River) !void {
    const RET = "Return";
    const MOD = mod_key;
    const S_MOD = mod_key ++ "+Shift";
    const C_MOD = mod_key ++ "+Control";
    // const SC_MOD = mod_key ++ "+Shift+Control";

    // Spawning apps
    try r.spawn(MOD, RET, terminal);
    try r.spawn(C_MOD, RET, fallback_terminal);
    try r.spawn(MOD, "D", launcher);

    // Spawning utils
    try r.spawn(MOD, "B", "~/.config/waybar/scripts/toggle.sh");
    try r.spawn(MOD, "C", "~/applications/bin/wl-color-picker.sh");
    try r.spawn(MOD, "W", "~/.config/river/scripts/toggleScreenScaling.sh");

    // Window management
    try r.bind("normal", MOD, "Q", &.{"close"});
    try r.bind("normal", S_MOD, "E", &.{"exit"});
    try r.bind("normal", MOD, "J", &.{ "focus-view", "next" });
    try r.bind("normal", MOD, "K", &.{ "focus-view", "previous" });
    try r.bind("normal", S_MOD, "J", &.{ "swap", "next" });
    try r.bind("normal", S_MOD, "K", &.{ "swap", "previous" });
    try r.bind("normal", MOD, "Space", &.{"toggle-float"});
    try r.bind("normal", MOD, "F", &.{"toggle-fullscreen"});
    try r.bind("normal", S_MOD, RET, &.{"zoom"});

    // Outputs management
    try r.bind("normal", MOD, "period", &.{ "focus-output", "next" });
    try r.bind("normal", MOD, "comma", &.{ "focus-output", "previous" });
    try r.bind("normal", S_MOD, "period", &.{ "send-to-output", "next" });
    try r.bind("normal", S_MOD, "comma", &.{ "send-to-output", "previous" });

    // Rivertile layout commands
    try r.bind("normal", MOD, "H", &.{ "send-layout-cmd", "rivertile", "main-ratio -0.05" });
    try r.bind("normal", MOD, "L", &.{ "send-layout-cmd", "rivertile", "main-ratio +0.05" });
    try r.bind("normal", MOD, "Plus", &.{ "send-layout-cmd", "rivertile", "main-count +1" });
    try r.bind("normal", MOD, "Minus", &.{ "send-layout-cmd", "rivertile", "main-count -1" });

    // Pointer bindings
    try r.bindPointer(MOD, "BTN_LEFT", "move-view");
    try r.bindPointer(MOD, "BTN_RIGHT", "resize-view");
    try r.bindPointer(MOD, "BTN_MIDDLE", "toggle-float");

    // System
    try r.spawn("None", "XF86AudioRaiseVolume", "pactl set-sink-volume @DEFAULT_SINK@ +5%");
    try r.spawn("None", "XF86AudioLowerVolume", "pactl set-sink-volume @DEFAULT_SINK@ -5%");
    try r.spawn("None", "XF86AudioMute", "pactl set-sink-mute @DEFAULT_SINK@ toggle");
    try r.spawn("None", "XF86MonBrightnessUp", "brightnessctl set +5%");
    try r.spawn("None", "XF86MonBrightnessDown", "brightnessctl set 5%-");
}
