const std = @import("std");
const Io = std.Io;

const HELP_MSG =
    \\Usage:
    \\  slopvine [<options>] <command>
    \\
    \\Available commands:
    \\  help
    \\Available options:
    \\
    \\
;

pub fn main(init: std.process.Init) !void {
    const allocator = init.arena.allocator();

    const args = try init.minimal.args.toSlice(allocator);

    var stdout_buffer: [1024]u8 = undefined;
    var stdout_writer = Io.File.stdout().writer(init.io, &stdout_buffer);
    const stdout = &stdout_writer.interface;

    try parseArgs(allocator, args, stdout);
}

fn parseArgs(_: std.mem.Allocator, args: []const [:0]const u8, writer: *Io.Writer) !void {
    var i: u8 = 1;
    while (i < args.len) : (i += 1) {
        const arg = args[i];

        if (std.mem.eql(u8, arg, "help")) {
            try writer.print("{s}", .{HELP_MSG});
            try writer.flush();
        }
    }
}
