# Automatic Theme Switching with Darkman & wlsunset

**Date**: 2025-12-27
**Status**: Approved Design

## Overview

Implement automatic theme switching between light and dark modes using darkman service, plus independent screen temperature adjustment with wlsunset. Both will use location-based timing (sunset/sunrise), but operate independently.

## Goals

- Automatic light/dark theme switching based on time of day
- All stylix-configured applications switch comprehensively
- Independent screen temperature tinting at night
- Safe switching that prevents rollbacks to failed/stale builds
- Manual override capability

## Architecture

### Three Main Components

1. **Dual Home-Manager Configurations**
   - Two complete home-manager configurations (light and dark variants)
   - Light: stylix configured with `rose-pine-dawn` theme
   - Dark: stylix configured with `rose-pine-moon` theme
   - Identical except for stylix theme and cursor theme
   - Exist as separate home-manager generations

2. **Darkman Service**
   - Systemd user service monitoring time based on geographic location
   - Calculates sunset/sunrise times automatically
   - Runs transition scripts at these times
   - Activates appropriate home-manager generation
   - Provides CLI for manual switching

3. **wlsunset Service**
   - Independent systemd user service for screen temperature
   - Location-based sunset/sunrise calculation
   - Gradually tints screen to warmer temperatures in evening
   - Operates independently of theme switching
   - Default temperature: 4000K (adjustable)

### Flow

1. Sunrise → darkman activates light config
2. Evening → wlsunset gradually warms screen
3. Sunset → darkman activates dark config
4. After sunrise → wlsunset removes tint

## Home-Manager Configuration Structure

### File Organization

```
homes/x86_64-linux/christopher@cobalt/
├── stylix.nix              # Main stylix module (common config)
├── stylix-theme.nix        # Theme selector with variants
└── config/
    └── appearance.nix      # GTK config (updated for theme switching)
```

### Dual Configurations

Use home-manager profiles/specializations to define two configurations in flake:
- `christopher@cobalt-light` - light theme variant
- `christopher@cobalt-dark` - dark theme variant

Both share common config modules but override stylix theme setting.

### Theme Configuration

- **Light theme**: `rose-pine-dawn`
- **Dark theme**: `rose-pine-moon`
- **Cursor themes**:
  - Light: `BreezeX-RosePineDawn-Linux`
  - Dark: `BreezeX-RosePineMoon-Linux` (or similar)

## Build Orchestration & Safety

### State File

Location: `$XDG_CACHE_HOME/theme-generations` (typically `~/.cache/theme-generations`)

Content:
```
light 145
dark 146
```

### Build Process

Custom wrapper command: `theme-rebuild`

1. Build and activate current theme (blocking)
2. **Delete state file** (prevents switching during build)
3. Build opposite theme (background)
4. **If build succeeds** → write state file with both generation numbers
5. **If build fails** → state file stays deleted

### Safety Mechanism

- State file only exists when both builds are ready
- During builds or after failures, file doesn't exist
- Darkman won't switch if file is missing
- Prevents switching to failed/stale builds
- No rollback risk

## Darkman Integration

### Service Configuration

```nix
services.darkman = {
  enable = true;
  settings = {
    lat = 47.6;    # User's latitude
    lng = -122.3;  # User's longitude
  };
};
```

### Service Behavior

- Runs as systemd user service
- Starts on login
- Monitors time based on coordinates
- Triggers scripts at sunset/sunrise
- Provides `darkman toggle` for manual switching

### Switch Scripts

Location:
- `~/.local/share/darkman/light-mode.d/00-theme-switch.sh`
- `~/.local/share/darkman/dark-mode.d/00-theme-switch.sh`

Script logic:
1. Read `$XDG_CACHE_HOME/theme-generations`
2. If file doesn't exist → exit (don't switch)
3. Parse generation numbers for target theme
4. Find generation path via `home-manager generations`
5. Activate generation: `<path>/activate`

### Manual Override

User can manually switch anytime: `darkman toggle`

## wlsunset Configuration

### Service Configuration

```nix
services.wlsunset = {
  enable = true;
  latitude = "47.6";    # Same location as darkman
  longitude = "-122.3";
  temperature = {
    day = 6500;    # Neutral/normal
    night = 4000;  # Warm/orange (adjustable)
  };
};
```

### Service Behavior

- Runs as systemd user service
- Starts on login (after Wayland compositor)
- Continuously adjusts screen temperature
- Smooth transitions (~1 hour around sunset/sunrise)
- Independent of theme switching

### Temperature Options

- `6500K` - Day temperature (neutral)
- `4000K` - Night temperature (moderate warmth) ← starting point
- Adjustable: `3400K` (very warm) to `4500K` (subtle)

### Compatibility

Works with Niri window manager via `wlr-gamma-control` protocol.

## Implementation Notes

### Wrapper Script

`theme-rebuild` command will:
- Detect current theme (light or dark)
- Build and activate current theme
- Delete cache file
- Build opposite theme in background
- On success, write cache file with generation numbers

### Location Configuration

User will need to provide latitude/longitude coordinates for both darkman and wlsunset. These should be stored in a common location and shared between both services.

### Testing

Manual testing workflow:
1. Run `theme-rebuild` - verify both builds succeed
2. Check cache file exists with two generation numbers
3. Test `darkman toggle` - verify smooth switching
4. Delete cache file - verify darkman refuses to switch
5. Verify wlsunset adjusts screen temperature independently

### Future Optimizations

If dual-config overhead becomes too large, can switch to Approach B:
- Single stylix config (one theme)
- Runtime overrides for specific apps via darkman scripts
- Less comprehensive but lighter weight

## Success Criteria

- [ ] Both light and dark themes build successfully
- [ ] Darkman switches themes at sunset/sunrise
- [ ] wlsunset adjusts screen temperature independently
- [ ] Failed builds don't break auto-switching
- [ ] Manual toggle works anytime
- [ ] All stylix-configured apps switch themes
- [ ] No rollbacks to stale configurations
