///Entry point
const std = @import("std");

//Core
const river = @import("src/riverWrapper.zig");
const config = @import("src/config.zig").config;

//Modules
const appearance = @import("src/modules/appearance.zig");
const keybindings = @import("src/modules/keybindings.zig");
const autostart = @import("src/modules/autostart.zig");
const tags = @import("src/modules/tags.zig");

pub fn main() !void {
    const heap = std.heap.page_allocator;

    var r = try river.River.init(heap);
    defer r.deinit();

    std.log.info("initializing modular river config...", .{});

    try keybindings.setup(&r, config);
    try appearance.setup(&r, config);
    try tags.setup(&r, config);
    try autostart.setup(&r, config);

    std.log.info("river initialization complete.", .{});
}
