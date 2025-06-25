const std = @import("std");
const river = @import("../riverWrapper.zig");
const keybindings = @import("keybindings.zig");

pub fn setup(r: *river.River) !void {
    const MOD = keybindings.mod_key;
    const S_MOD = MOD ++ "+Shift";

    try r.bind("normal", MOD, "y", &.{ "set-focused-tags", "1" });
    try r.bind("normal", MOD, "u", &.{ "set-focused-tags", "2" });
    try r.bind("normal", MOD, "i", &.{ "set-focused-tags", "4" });
    try r.bind("normal", MOD, "o", &.{ "set-focused-tags", "8" });
    try r.bind("normal", MOD, "p", &.{ "set-focused-tags", "16" });
    try r.bind("normal", MOD, "Backslash", &.{ "set-focused-tags", "32" });
    try r.bind("normal", S_MOD, "y", &.{ "set-view-tags", "1" });
    try r.bind("normal", S_MOD, "u", &.{ "set-view-tags", "2" });
    try r.bind("normal", S_MOD, "i", &.{ "set-view-tags", "4" });
    try r.bind("normal", S_MOD, "o", &.{ "set-view-tags", "8" });
    try r.bind("normal", S_MOD, "p", &.{ "set-view-tags", "16" });
    try r.bind("normal", S_MOD, "Backslash", &.{ "set-view-tags", "32" });
}
