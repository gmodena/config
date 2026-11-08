// =============================================================================
// TRAINING 01: Motions & Text Objects in Zig
// =============================================================================
// Open this file in Neovim and follow the exercises.
// Each exercise tells you WHERE to put your cursor and WHAT to type.
// Do NOT use the mouse. That's the whole point.
// =============================================================================

// ---------------------------------------------------------------------------
// EXERCISE 1: Word motions (w, b, e)
// ---------------------------------------------------------------------------
// Put your cursor on "const" below. Press w repeatedly to jump word by word.
// Then press b to go back. Press e to land on the end of each word.
//
// Try: 3w (jump 3 words), 2b (back 2 words)

const std = @import("std");

const allocator = std.heap.page_allocator;

// ---------------------------------------------------------------------------
// EXERCISE 2: Line motions (0, ^, $, f, t)
// ---------------------------------------------------------------------------
// Put cursor anywhere on the line below.
// 0   -> go to column 0
// ^   -> go to first non-space character
// $   -> go to end of line
// f(  -> jump to the (
// t)  -> jump to just before the )
// ;   -> repeat the last f/t jump

fn calculateSum(a: i32, b: i32, c: i32) i32 {
    return a + b + c;
}

// ---------------------------------------------------------------------------
// EXERCISE 3: Block motions ({ } and %)
// ---------------------------------------------------------------------------
// Put cursor on the opening { of processData.
// Press % to jump to matching }. Press % again to jump back.
// Press { and } to jump between blank-line-separated paragraphs.

fn processData(data: []const u8) !void {
    if (data.len == 0) {
        return error.EmptyData;
    }

    var sum: u64 = 0;
    for (data) |byte| {
        sum += byte;
    }

    if (sum > 1000) {
        std.debug.print("Large sum: {}\n", .{sum});
    }
}

// ---------------------------------------------------------------------------
// EXERCISE 4: Text objects - change inside (ci)
// ---------------------------------------------------------------------------
// Put cursor inside the quotes on the print line below.
// Type ci" then type a new message. Press Esc.
// Now put cursor inside the .{} and type ci{ to change the format args.

fn greet(name: []const u8) void {
    std.debug.print("Hello, {}! Welcome to Zig.\n", .{name});
}

// ---------------------------------------------------------------------------
// EXERCISE 5: Text objects - delete/yank around (da, ya)
// ---------------------------------------------------------------------------
// Put cursor on "unused_param" below.
// Type daw to delete the word and its trailing space.
// Undo with u. Now try diw (deletes word only, keeps space).
//
// Put cursor inside the parens of the return statement.
// Type yi( to yank inside parens. Move elsewhere and p to paste.

fn compute(x: f64, unused_param: f64) f64 {
    return (x * x + 2.0 * x + 1.0);
}

// ---------------------------------------------------------------------------
// EXERCISE 6: Function text objects (vaf, vif, daf)
// ---------------------------------------------------------------------------
// Put cursor anywhere inside badFunction below.
// Type vaf to select the entire function. Press Esc.
// Type vif to select just the function body. Press Esc.
// Type daf to delete the entire function. Undo with u.

fn badFunction() void {
    // This function does nothing useful.
    // In a real codebase you would delete it.
    var x: i32 = 0;
    _ = x;
}

// ---------------------------------------------------------------------------
// EXERCISE 7: Combining motions with operators
// ---------------------------------------------------------------------------
// Put cursor on the "v" of "var" in the first line of main.
// d]] -> delete from here to the next function start
// (undo with u)
//
// Put cursor on "Hello" below.
// c$ -> change from cursor to end of line (type new text, Esc)
// (undo with u)
//
// Put cursor on the first "try".
// y2j -> yank this line and the 2 below. Go somewhere else, p to paste.

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();

    const ally = gpa.allocator();

    var list = std.ArrayList(u8).init(ally);
    defer list.deinit();

    try list.append('H');
    try list.append('i');
    try list.append('!');

    std.debug.print("{s}\n", .{list.items});
}

// ---------------------------------------------------------------------------
// EXERCISE 8: Search and jump (/, *, #, gd)
// ---------------------------------------------------------------------------
// Type /processData and Enter to jump to that function.
// Press n to find next match, N for previous.
//
// Put cursor on "sum" inside processData. Press * to find next occurrence.
// Press # to find previous occurrence.
//
// Put cursor on "ally" in main(). Press gd to go to its definition.
// Press Ctrl-o to jump back.

// ---------------------------------------------------------------------------
// EXERCISE 9: Marks and jumps
// ---------------------------------------------------------------------------
// Go to main(). Press ma to set mark 'a'.
// Go to processData(). Press mb to set mark 'b'.
// Now type 'a to jump back to main. Type 'b to jump to processData.
// Type `` (backtick backtick) to toggle between last two positions.

// ---------------------------------------------------------------------------
// EXERCISE 10: Macros (record and replay)
// ---------------------------------------------------------------------------
// This is messy. Each line needs "pub " prepended.
// Put cursor on the f of "fn" on the first line.
// qa       -> start recording macro into register a
// I        -> insert at beginning of line
// pub      -> type "pub "
// Esc      -> back to normal mode
// j^       -> go to next line, first non-blank
// q        -> stop recording
// 2@a      -> replay macro 2 times (for remaining lines)

fn helperOne() void {}
fn helperTwo() void {}
fn helperThree() void {}
