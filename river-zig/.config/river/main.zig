const std = @import("std");
const river = @import("src/riverWrapper.zig");
const keybindings = @import("src/modules/keybindings.zig");
const appearance = @import("src/modules/appearance.zig");
const autostart = @import("src/modules/autostart.zig");
const tags = @import("src/modules/tags.zig");

pub fn main() !void {
    const heap = std.heap.page_allocator;
    var r = try river.River.init(heap);
    defer r.deinit();

    try keybindings.setup(&r);
    try appearance.setup(&r);
    try tags.setup(&r);
    try autostart.setup(&r);
}
