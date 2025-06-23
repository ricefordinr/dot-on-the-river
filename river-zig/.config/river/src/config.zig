pub const config = .{
    .mod_key = "Alt",
    .terminal = "foot",
    .launcher = "fuzzel",

    .appearance = .{
        .background_color = 0xffffff,
        .border_focused_color = 0x93a1a1,
        .border_unfocused_color = 0x586e75,
    },

    // For rivertile)
    .layout = .{
        .view_padding = 6,
        .outer_padding = 6,
    },

    // Keyboard repeat rate
    .keyboard = .{
        .repeat_rate = 50,
        .repeat_delay = 300,
    },
};
