---
title: Keybinding Action Reference
description: Reference of all Ghostty keybinding actions.
editOnGithubLink: https://github.com/ghostty-org/ghostty/edit/main/src/input/Binding.zig
---

This is a reference of all Ghostty keybinding actions.

## `ignore`

Ignore this key combination, don't send it to the child process, just
black hole it.

## `unbind`

This action is used to flag that the binding should be removed from
the set. This should never exist in an active set and `set.put` has an
assertion to verify this.

## `csi`

Send a CSI sequence. The value should be the CSI sequence without the
CSI header (`ESC [` or `\x1b[`).

## `esc`

Send an `ESC` sequence.

## `text`

Send the given text. Uses Zig string literal syntax. This is currently
not validated. If the text is invalid (i.e. contains an invalid escape
sequence), the error will currently only show up in logs.

## `cursor_key`

Send data to the pty depending on whether cursor key mode is enabled
(`application`) or disabled (`normal`).

## `reset`

Reset the terminal. This can fix a lot of issues when a running
program puts the terminal into a broken state. This is equivalent to
when you type "reset" and press enter.

If you do this while in a TUI program such as vim, this may break
the program. If you do this while in a shell, you may have to press
enter after to get a new prompt.

## `copy_to_clipboard`

## `paste_from_clipboard`

## `paste_from_selection`

Copy and paste.

## `copy_url_to_clipboard`

Copy the URL under the cursor to the clipboard. If there is no
URL under the cursor, this does nothing.

## `increase_font_size`

## `decrease_font_size`

Increase/decrease the font size by a certain amount.

## `reset_font_size`

Reset the font size to the original configured size.

## `clear_screen`

Clear the screen. This also clears all scrollback.

## `select_all`

Select all text on the screen.

## `scroll_to_top`

## `scroll_to_bottom`

## `scroll_page_up`

## `scroll_page_down`

## `scroll_page_fractional`

## `scroll_page_lines`

Scroll the screen varying amounts.

## `adjust_selection`

Adjust the current selection in a given direction. Does nothing if no
selection exists.

Arguments:

- left, right, up, down, page_up, page_down, home, end,
  beginning_of_line, end_of_line

Example: Extend selection to the right
keybind = shift+right=adjust_selection:right

## `jump_to_prompt`

Jump the viewport forward or back by prompt. Positive number is the
number of prompts to jump forward, negative is backwards.

## `write_scrollback_file`

Write the entire scrollback into a temporary file. The action
determines what to do with the filepath. Valid values are:

- "paste": Paste the file path into the terminal.
- "open": Open the file in the default OS editor for text files.
  The default OS editor is determined by using `open` on macOS
  and `xdg-open` on Linux.

## `write_screen_file`

Same as write_scrollback_file but writes the full screen contents.
See write_scrollback_file for available values.

## `write_selection_file`

Same as write_scrollback_file but writes the selected text.
If there is no selected text this does nothing (it doesn't
even create an empty file). See write_scrollback_file for
available values.

## `new_window`

Open a new window. If the application isn't currently focused,
this will bring it to the front.

## `new_tab`

Open a new tab.

## `previous_tab`

Go to the previous tab.

## `next_tab`

Go to the next tab.

## `last_tab`

Go to the last tab (the one with the highest index)

## `goto_tab`

Go to the tab with the specific number, 1-indexed. If the tab number
is higher than the number of tabs, this will go to the last tab.

## `move_tab`

Moves a tab by a relative offset.
Adjusts the tab position based on `offset`. For example `move_tab:-1` for left, `move_tab:1` for right.
If the new position is out of bounds, it wraps around cyclically within the tab range.

## `toggle_tab_overview`

Toggle the tab overview.
This only works with libadwaita enabled currently.

## `new_split`

Create a new split in the given direction.

Arguments:

- right, down, left, up, auto (splits along the larger direction)

Example: Create split on the right
keybind = cmd+shift+d=new_split:right

## `goto_split`

Focus on a split in a given direction. For example `goto_split:up`.
Valid values are left, right, up, down, previous and next.

## `toggle_split_zoom`

zoom/unzoom the current split.

## `resize_split`

Resize the current split in a given direction.

Arguments:

- up, down, left, right
- the number of pixels to resize the split by

Example: Move divider up 10 pixels
keybind = cmd+shift+up=resize_split:up,10

## `equalize_splits`

Equalize all splits in the current window

## `inspector`

Control the terminal inspector visibility.

Arguments:

- toggle, show, hide

Example: Toggle inspector visibility
keybind = cmd+i=inspector:toggle

## `open_config`

Open the configuration file in the default OS editor. If your default OS
editor isn't configured then this will fail. Currently, any failures to
open the configuration will show up only in the logs.

## `reload_config`

Reload the configuration. The exact meaning depends on the app runtime
in use but this usually involves re-reading the configuration file
and applying any changes. Note that not all changes can be applied at
runtime.

## `close_surface`

Close the current "surface", whether that is a window, tab, split, etc.
This only closes ONE surface. This will trigger close confirmation as
configured.

## `close_tab`

Close the current tab, regardless of how many splits there may be.
This will trigger close confirmation as configured.

## `close_window`

Close the window, regardless of how many tabs or splits there may be.
This will trigger close confirmation as configured.

## `close_all_windows`

Close all windows. This will trigger close confirmation as configured.
This only works for macOS currently.

## `toggle_maximize`

Toggle maximized window state. This only works on Linux.

## `toggle_fullscreen`

Toggle fullscreen mode of window.

## `toggle_window_decorations`

Toggle window decorations on and off. This only works on Linux.

## `toggle_secure_input`

Toggle secure input mode on or off. This is used to prevent apps
that monitor input from seeing what you type. This is useful for
entering passwords or other sensitive information.

This applies to the entire application, not just the focused
terminal. You must toggle it off to disable it, or quit Ghostty.

This only works on macOS, since this is a system API on macOS.

## `toggle_quick_terminal`

Toggle the "quick" terminal. The quick terminal is a terminal that
appears on demand from a keybinding, often sliding in from a screen
edge such as the top. This is useful for quick access to a terminal
without having to open a new window or tab.

When the quick terminal loses focus, it disappears. The terminal state
is preserved between appearances, so you can always press the keybinding
to bring it back up.

To enable the quick terminal globally so that Ghostty doesn't
have to be focused, prefix your keybind with `global`. Example:

```ini
keybind = global:cmd+grave_accent=toggle_quick_terminal
```

The quick terminal has some limitations:

- It is a singleton; only one instance can exist at a time.
- It does not support tabs, but it does support splits.
- It will not be restored when the application is restarted
  (for systems that support window restoration).
- It supports fullscreen, but fullscreen will always be a non-native
  fullscreen (macos-non-native-fullscreen = true). This only applies
  to the quick terminal window. This is a requirement due to how
  the quick terminal is rendered.

See the various configurations for the quick terminal in the
configuration file to customize its behavior.

This currently only works on macOS.

## `toggle_visibility`

Show/hide all windows. If all windows become shown, we also ensure
Ghostty becomes focused. When hiding all windows, focus is yielded
to the next application as determined by the OS.

Note: When the focused surface is fullscreen, this method does nothing.

This currently only works on macOS.

## `quit`

Quit ghostty.

## `crash`

Crash ghostty in the desired thread for the focused surface.

WARNING: This is a hard crash (panic) and data can be lost.

The purpose of this action is to test crash handling. For some
users, it may be useful to test crash reporting functionality in
order to determine if it all works as expected.

The value determines the crash location:

- "main" - crash on the main (GUI) thread.
- "io" - crash on the IO thread for the focused surface.
- "render" - crash on the render thread for the focused surface.
