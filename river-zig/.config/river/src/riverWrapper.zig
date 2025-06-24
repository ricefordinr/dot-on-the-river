//Hey you, you don't have to modify this file
const std = @import("std");

pub const River = struct {
    gpa: *std.heap.GeneralPurposeAllocator(.{}),
    bootstrap_allocator: std.mem.Allocator,
    allocator: std.mem.Allocator,

    /// This is constructor
    pub fn init(bootstrap_allocator: std.mem.Allocator) !River {
        const gpa_ptr = try bootstrap_allocator.create(std.heap.GeneralPurposeAllocator(.{}));
        gpa_ptr.* = .{};
        return .{
            .gpa = gpa_ptr,
            .bootstrap_allocator = bootstrap_allocator,
            .allocator = gpa_ptr.allocator(),
        };
    }

    /// This is not constructor
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

    /// Don't ask why this exists
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

    /// Spawn applications with keypress
    pub fn spawn(self: *River, modifiers: []const u8, key: []const u8, command: []const u8) !void {
        try self.bind("normal", modifiers, key, &.{ "spawn", command });
    }

    /// Also bind() but for pointer
    pub fn bindPointer(self: *River, modifiers: []const u8, button: []const u8, action: []const u8) !void {
        try self.cmd(&.{ "map-pointer", "normal", modifiers, button, action });
    }

    /// Spawn without keypress
    pub fn start(self: *River, argv: []const []const u8) !void {
        var child = std.process.Child.init(argv, self.allocator);
        try child.spawn();
    }

    /// Add window rules to matching id AND title
    pub fn rule(self: *River, ruleName: []const u8, matcher: struct {
        title: []const u8 = "",
        id: []const u8 = "",
        arg: []const u8 = "",
    }) !void {
        var arg_list = std.ArrayList([]const u8).init(self.allocator);
        defer arg_list.deinit();

        try arg_list.append("rule-add");
        if (!std.mem.eql(u8, matcher.id, "")) {
            try arg_list.appendSlice(&[_][]const u8{ "-app-id", matcher.id });
        }
        if (!std.mem.eql(u8, matcher.title, "")) {
            try arg_list.appendSlice(&[_][]const u8{ "-title", matcher.title });
        }

        try arg_list.append(ruleName);
        if (!std.mem.eql(u8, matcher.arg, "")) {
            try arg_list.append(matcher.arg);
        }

        try self.run(arg_list.items);
    }
};
