const std = @import("std");
const river = @import("../riverWrapper.zig");

pub const mod_key = "Alt";
const terminal = "foot";
const launcher = "dmenu_run";

pub fn setup(r: *river.River) !void {
    const MOD = mod_key;
    const SHIFT_MOD = mod_key ++ "+Shift";

    // Spawning apps
    try r.spawn(MOD, "Return", terminal);
    try r.spawn(MOD, "D", launcher);

    // Window management
    try r.bind("normal", MOD, "Q", &.{"close"});
    try r.bind("normal", SHIFT_MOD, "E", &.{"exit"});
    try r.bind("normal", MOD, "J", &.{ "focus-view", "next" });
    try r.bind("normal", MOD, "K", &.{ "focus-view", "previous" });

    // Rivertile layout commands
    try r.bind("normal", MOD, "H", &.{ "send-layout-cmd", "rivertile", "main-ratio -0.05" });
    try r.bind("normal", MOD, "L", &.{ "send-layout-cmd", "rivertile", "main-ratio +0.05" });

    // Pointer bindings
    try r.bindPointer(MOD, "BTN_LEFT", "move-view");
    try r.bindPointer(MOD, "BTN_RIGHT", "resize-view");
}
