const std = @import("std");
const river = @import("src/riverWrapper.zig");
const keybindings = @import("src/modules/keybindings.zig");
const appearance = @import("src/modules/appearance.zig");
const autostart = @import("src/modules/autostart.zig");
const tags = @import("src/modules/tags.zig");
const inputs = @import("src/modules/inputs.zig");
const layout = @import("src/modules/layout.zig");
const rules = @import("src/modules/rules.zig");

pub fn main() !void {
    const heap = std.heap.page_allocator;
    var r = try river.River.init(heap);
    defer r.deinit();

    try keybindings.setup(&r);
    try appearance.setup(&r);
    try autostart.setup(&r);
    try tags.setup(&r);
    try inputs.setup(&r);
    try layout.setup(&r);
    try rules.setup(&r);
}
