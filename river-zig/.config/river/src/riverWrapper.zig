//Hey you, you don't have to modify this file
const std = @import("std");

pub const River = struct {
    gpa: *std.heap.GeneralPurposeAllocator(.{}),
    bootstrap_allocator: std.mem.Allocator,
    allocator: std.mem.Allocator,

    pub fn init(bootstrap_allocator: std.mem.Allocator) !River {
        const gpa_ptr = try bootstrap_allocator.create(std.heap.GeneralPurposeAllocator(.{}));
        gpa_ptr.* = .{};
        return .{
            .gpa = gpa_ptr,
            .bootstrap_allocator = bootstrap_allocator,
            .allocator = gpa_ptr.allocator(),
        };
    }

    pub fn deinit(self: *River) void {
        _ = self.gpa.deinit();
        self.bootstrap_allocator.destroy(self.gpa);
    }

    /// This function simply takes lots of string and run riverctl
    fn run(self: *River, args: []const []const u8) !void {
        var argv = std.ArrayList([]const u8).init(self.allocator);
        defer argv.deinit();

        try argv.append("riverctl");
        try argv.appendSlice(args);

        const result = try std.process.Child.run(.{ .allocator = self.allocator, .argv = argv.items });
        self.allocator.free(result.stdout);
        self.allocator.free(result.stderr);
    }

    /// Don't ask why this exist
    pub fn cmd(self: *River, args: []const []const u8) !void {
        try self.run(args);
    }

    /// This function also sends lots of strings to run()
    pub fn bind(self: *River, mode: []const u8, modifiers: []const u8, key: []const u8, args: []const []const u8) !void {
        var arg_list = std.ArrayList([]const u8).init(self.allocator);
        defer arg_list.deinit();

        try arg_list.appendSlice(&[_][]const u8{ "map", mode, modifiers, key });
        try arg_list.appendSlice(args);

        try self.run(arg_list.items);
    }

    /// This send to bind() instead
    pub fn spawn(self: *River, modifiers: []const u8, key: []const u8, command: []const u8) !void {
        try self.bind("normal", modifiers, key, &.{ "spawn", command });
    }

    /// Also bind() but for pointer
    pub fn bindPointer(self: *River, modifiers: []const u8, button: []const u8, action: []const u8) !void {
        try self.cmd(&.{ "map-pointer", "normal", modifiers, button, action });
    }

    /// Same as spawn(), but processes are not owned by river
    pub fn start(self: *River, argv: []const []const u8) !void {
        var child = std.process.Child.init(argv, self.allocator);
        try child.spawn();
    }
};
