const std = @import("std");
const river = @import("../riverWrapper.zig");

// All modules must export a `setup` function with this signature.
pub fn setup(r: *river.River, conf: anytype) !void {
    const MOD = conf.mod_key;
    const SHIFT_MOD = MOD ++ "+Shift";
    // const CONTROL_MOD = MOD ++ "+Control";
    // const ALT_MOD = MOD ++ "+Alt";

    // Spawning apps
    try r.spawn(MOD, "Return", conf.terminal);
    try r.spawn(MOD, "D", conf.launcher);

    // Window management
    try r.bind("normal", MOD, "Q", .{"close"});
    try r.bind("normal", SHIFT_MOD, "E", .{"exit"});
    try r.bind("normal", MOD, "J", .{ "focus-view", "next" });
    try r.bind("normal", MOD, "K", .{ "focus-view", "previous" });
    try r.bind("normal", SHIFT_MOD, "J", .{ "swap", "next" });
    try r.bind("normal", SHIFT_MOD, "K", .{ "swap", "previous" });
    try r.bind("normal", MOD, "F", .{"toggle-fullscreen"});
    try r.bind("normal", MOD, "Space", .{"toggle-float"});

    // rivertile layout commands
    try r.bind("normal", MOD, "H", .{ "send-layout-cmd", "rivertile", "main-ratio -0.05" });
    try r.bind("normal", MOD, "L", .{ "send-layout-cmd", "rivertile", "main-ratio +0.05" });

    // Pointer bindings
    try r.bindPointer(MOD, "BTN_LEFT", "move-view");
    try r.bindPointer(MOD, "BTN_RIGHT", "resize-view");
    try r.bindPointer(MOD, "BTN_MIDDLE", "toggle-float");
}
