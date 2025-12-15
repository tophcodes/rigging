{
  lib,
  pkgs,
  ...
}:
lib._elements.writeNushellApplication pkgs {
  name = "spawn-term";
  runtimeInputs = with pkgs; [kdotool];

  text = ''
    let compositor = $env.XDG_CURRENT_DESKTOP? | default ""

    let window_info = if ($compositor | str contains "niri") {
      let focused_window = (niri msg --json focused-window | from json | get id?)
      if ($focused_window | is-empty) {
        { is_kitty: false, pid: null }
      } else {
        let info = (niri msg --json windows | from json | where id == $focused_window | first)
        { is_kitty: ($info.app_id? == "kitty"), pid: $info.pid? }
      }
    } else {
      let focused_window = (kdotool getactivewindow)
      {
        is_kitty: ((kdotool getwindowclassname $focused_window) == "kitty"),
        pid: (kdotool getwindowpid $focused_window | into int)
      }
    }

    if $window_info.is_kitty {
      let kitty_pid = $window_info.pid
      if ($kitty_pid | is-empty) {
        kitty
        exit 0
      }

      let shell_pid = (ps | where ppid == $kitty_pid | where name != "kitten" | get pid | first)
      if ($shell_pid | is-empty) {
        kitty
        exit 0
      }

      let path = ($"/proc/($shell_pid)/cwd" | path expand)
      kitty --directory $path
    } else {
      kitty
    }
  '';
}
