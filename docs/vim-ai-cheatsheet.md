# Vim + AI Cheatsheet
## CodeCompanion (Claude API) + Code Review Workflow

---

## 1. CodeCompanion Commands

| Command                          | What it does                              |
|----------------------------------|-------------------------------------------|
| `:CodeCompanionChat`             | Open a chat buffer with Claude            |
| `:CodeCompanion <prompt>`        | Inline AI edit on current buffer/selection |
| `:CodeCompanionActions`          | Open action palette (explain, review, ...) |
| `:CodeCompanionCmd <prompt>`     | Run a command via AI                      |

### Inline mode keys (after `:CodeCompanion` on a selection)

| Key  | Action        |
|------|---------------|
| `ga` | Accept change |
| `gr` | Reject change |

---

## 2. AI-Assisted Code Review Workflow

### Review a function

```
1.  vaf                       Select around function (treesitter)
2.  :CodeCompanionActions     Pick "Review" from the palette
    -- or --
    :CodeCompanion review this for bugs, edge cases, and idiomatic style
```

### Explain unfamiliar code

```
1.  vif                       Select inner function body
2.  :CodeCompanion explain this code step by step
```

### Refactor a block

```
1.  V then j/k to select lines
2.  :CodeCompanion refactor: extract a helper function
```

### Review a git diff

```
1.  :Gdiffsplit                Open side-by-side diff (fugitive)
2.  ]c / [c                    Jump between changed hunks
3.  Select changed code with V
4.  :CodeCompanion review this change for correctness
```

### Chat about architecture

```
1.  :CodeCompanionChat
2.  Type: "I'm working on a Zig allocator. How should I handle..."
3.  Use @buf to reference the current buffer in chat
4.  Use #buf to add a buffer as context
```

---

## 3. Visual Selection (the gateway to AI)

You need to select code before sending it to CodeCompanion.

| Keys        | Selects                                |
|-------------|----------------------------------------|
| `v`         | Character-wise (start selecting)       |
| `V`         | Line-wise (whole lines)                |
| `Ctrl-v`    | Block/column selection                 |
| `vif`       | Inner function body (treesitter)       |
| `vaf`       | Entire function including signature    |
| `vic`       | Inner class body                       |
| `vac`       | Entire class                           |
| `vi{`       | Inside braces                          |
| `vi(`       | Inside parentheses                     |
| `vi"`       | Inside double quotes                   |
| `vip`       | Inner paragraph (blank-line delimited) |

After selecting, type `:` to enter command mode (shows `:'<,'>`) then type your CodeCompanion command.

---

## 4. Essential Motions for Code Navigation

### Moving around

| Keys        | Motion                                  |
|-------------|-----------------------------------------|
| `w` / `b`   | Next / previous word                    |
| `e`         | End of word                             |
| `0` / `$`   | Start / end of line                     |
| `^`         | First non-blank character               |
| `gg` / `G`  | Top / bottom of file                    |
| `{` / `}`   | Previous / next blank line (paragraph)  |
| `%`         | Matching bracket/paren                  |
| `f<char>`   | Jump to next <char> on line             |
| `t<char>`   | Jump to just before <char> on line      |
| `;` / `,`   | Repeat / reverse last f/t               |

### Code-aware (treesitter + LSP)

| Keys        | Motion                                  |
|-------------|-----------------------------------------|
| `]]` / `[[` | Next / previous function start          |
| `]m` / `[m` | Next / previous method start            |
| `gd`        | Go to definition                        |
| `gD`        | Go to declaration                       |
| `gr`        | Go to references                        |
| `gi`        | Go to implementation                    |
| `K`         | Hover docs                              |
| `]d` / `[d` | Next / previous diagnostic              |
| `Ctrl-o`    | Jump back (after gd, etc.)              |
| `Ctrl-i`    | Jump forward                            |

---

## 5. Editing Verbs + Text Objects

Vim editing = **verb** + **target**

### Verbs

| Key | Verb     | Example          |
|-----|----------|------------------|
| `d` | Delete   | `daf` = delete function |
| `c` | Change   | `ci"` = change inside quotes |
| `y` | Yank     | `yif` = copy function body |
| `v` | Visual   | `vaf` = select function |
| `>` | Indent   | `>af` = indent function |
| `<` | Dedent   | `<af` = dedent function  |

### Text objects (targets)

| Object | Meaning             | Use case                        |
|--------|---------------------|---------------------------------|
| `iw`   | inner word          | rename a variable: `ciw`        |
| `aw`   | a word (with space) | delete word + space: `daw`      |
| `i"`   | inside quotes       | change string content: `ci"`    |
| `a"`   | around quotes       | delete string + quotes: `da"`   |
| `i{`   | inside braces       | change block body: `ci{`        |
| `i(`   | inside parens       | change arguments: `ci(`         |
| `if`   | inner function      | select/edit function body: `vif`|
| `af`   | around function     | select whole function: `daf`    |
| `ic`   | inner class         | select class body: `vic`        |

---

## 6. Surround (nvim-surround)

| Action          | Keys            | Example                        |
|-----------------|-----------------|--------------------------------|
| Add surround    | `ys<motion><c>` | `ysiw"` = wrap word in `"`     |
| Change surround | `cs<old><new>`  | `cs"'` = change `"` to `'`    |
| Delete surround | `ds<char>`      | `ds(` = remove parens          |
| Visual surround | `S<char>`       | Select, `S{` = wrap in `{}`   |

### Common patterns

```
ysiw"      word -> "word"
ysiw(      word -> ( word )       (with spaces)
ysiw)      word -> (word)         (no spaces)
ys$"       cursor to end of line -> wrap in "
yss"       entire line -> wrap in "
cs([       ( x ) -> [ x ]
ds{        { x } -> x
```

---

## 7. Git + Code Review (fugitive + gitsigns)

### Fugitive

| Command           | What it does                    |
|-------------------|---------------------------------|
| `:Git`            | Git status (interactive)        |
| `:Git diff`       | Show diff                       |
| `:Gdiffsplit`     | Side-by-side diff of file       |
| `:Git log --oneline` | Commit log                   |
| `:Git blame`      | Inline blame                    |
| `:Gread`          | Revert buffer to git version    |

### Gitsigns (hunk navigation)

| Keys              | What it does                    |
|-------------------|---------------------------------|
| `]c`              | Next changed hunk               |
| `[c`              | Previous changed hunk           |
| `:Gitsigns stage_hunk`         | Stage current hunk |
| `:Gitsigns undo_stage_hunk`    | Unstage hunk       |
| `:Gitsigns reset_hunk`         | Discard hunk       |
| `:Gitsigns preview_hunk`       | Preview hunk diff  |
| `:Gitsigns toggle_current_line_blame` | Toggle blame |

---

## 8. Telescope (fuzzy finder)

| Keys / Command      | What it does                  |
|----------------------|-------------------------------|
| `:Telescope find_files`    | Find file by name       |
| `:Telescope live_grep`     | Search text across files|
| `:Telescope lsp_references`| Find references         |
| `:Telescope lsp_definitions` | Find definitions      |
| `:Telescope git_status`    | Changed files           |
| `:Telescope git_commits`   | Browse commits          |
| `:Telescope diagnostics`   | All warnings/errors     |

Inside Telescope: `Ctrl-j`/`Ctrl-k` to navigate, `Enter` to select, `Ctrl-v` for vsplit.

---

## 9. Trouble (diagnostics panel)

| Command                    | What it does                   |
|----------------------------|--------------------------------|
| `:Trouble diagnostics`     | Show all diagnostics           |
| `:Trouble lsp_references`  | Show references panel          |
| `]d` / `[d`               | Jump between diagnostics       |

---

## 10. Quick Reference Combos

### "Review this PR diff with AI"
```
:Git diff main             see what changed
:Gdiffsplit                side-by-side for current file
]c                         jump to next hunk
V (select hunk)
:CodeCompanion review this change
```

### "Refactor a Zig function"
```
vaf                        select entire function
:CodeCompanion refactor: simplify error handling
ga                         accept / gr reject
```

### "Understand Go interface"
```
gd                         go to definition
vac                        select the whole type
:CodeCompanion explain this interface and its contracts
```

### "Fix Java boilerplate"
```
vif                        select function body
:CodeCompanion modernize this to use streams/records where appropriate
```

### "Wrap return value in error union (Zig)"
```
f!                         jump to ! on the line
ysiw)                      wrap the error in parens
```
