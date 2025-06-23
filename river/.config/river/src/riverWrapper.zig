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

    fn run(self: *River, args: []const []const u8) !void {
        var argv = std.ArrayList([]const u8).init(self.allocator);
        defer argv.deinit();

        try argv.append("riverctl");
        try argv.appendSlice(args);

        const result = try std.process.Child.run(.{
            .allocator = self.allocator,
            .argv = argv.items,
        });
        self.allocator.free(result.stdout);
        self.allocator.free(result.stderr);

        if (result.term.Exited != 0) {
            std.log.warn("`riverctl` command failed with exit code {d}: {s}", .{
                result.term.Exited,
                result.stderr,
            });
        }
    }

    pub fn cmd(self: *River, args: anytype) !void {
        try self.run(&args);
    }

    pub fn bind(self: *River, mode: []const u8, modifiers: []const u8, key: []const u8, args: anytype) !void {
        var argv = std.ArrayList([]const u8).init(self.allocator);
        defer argv.deinit();

        try argv.appendSlice(&[_][]const u8{ "map", mode, modifiers, key });

        inline for (args) |arg| {
            try argv.append(arg);
        }

        try self.run(argv.items);
    }

    pub fn spawn(self: *River, modifiers: []const u8, key: []const u8, command: []const u8) !void {
        try self.bind("normal", modifiers, key, .{ "spawn", command });
    }

    pub fn bindPointer(self: *River, modifiers: []const u8, button: []const u8, action: []const u8) !void {
        try self.cmd(.{ "map-pointer", "normal", modifiers, button, action });
    }

    pub fn start(self: *River, argv: []const []const u8) !void {
        var child = std.process.Child.init(argv, self.allocator);
        try child.spawn();
    }
};
