# Design System

Code: `lib/ui/core/themes/` (tokens) and `lib/ui/core/ui/base/` (widgets).

A calm, modern look: soft near-white (light) or deep near-black (dark) surfaces, one vivid gradient accent, big rounded cards and generous spacing. The chrome stays quiet so content stands out. Light and dark are both first-class; the app follows the system setting, with an override in Settings.

## Principles

1. **One accent.** The Aurora gradient marks the one primary action on a screen, progress, selection and the active tab. Everything else is neutral.
2. **Cards, not lines.** Content sits in rounded cards separated from the background by colour (plus a 1px outline in light mode).
3. **Calm feedback.** Progress animates; numbers that update use tabular figures; toasts slide in at the top.
4. **Undoable, or asked.** Destructive actions always confirm; nothing is deleted on a single tap.

## Colour

### Brand gradient: "Aurora"

| Stop | Hex | Use |
| --- | --- | --- |
| 0% | `#6A4CF5` (violet) | Start of every gradient; solid primary when a gradient doesn't fit |
| 50% | `#B44CF0` (orchid) | Middle stop |
| 100% | `#FF4D8D` (pink) | End stop |

Used for: primary buttons, progress (bars and rings), the active nav indicator, selected chips, checked checkboxes, and a soft glow (`AuroraGlow`) behind headers. Never as a full-screen background or behind body text.

### Theme tokens

All colours come from `AppColors` (a `ThemeExtension`, read with `context.colors`). Never write a hex value in a widget.

| Token | Dark | Light | Use |
| --- | --- | --- | --- |
| `background` | `#0B0B12` | `#F7F7FB` | Scaffold |
| `surface` | `#14141F` | `#FFFFFF` | Cards, sheets |
| `surfaceRaised` | `#1C1C2A` | `#F0F0F7` | Inputs, chips, nested tiles |
| `outline` | `#2A2A3C` | `#E2E2EC` | 1px borders, dividers |
| `textPrimary` | `#F5F5FA` | `#0F0F1A` | Titles, body |
| `textSecondary` | `#A1A1B5` | `#5B5B70` | Metadata |
| `textMuted` | `#6B6B80` | `#8E8EA3` | Placeholders, disabled |
| `primary` | `#6A4CF5` | `#6A4CF5` | Solid fills with white text (5.3:1) |
| `primaryText` | `#8B73FF` | `#5A3DE6` | Links, icons and accent text |
| `secondary` | `#22D3EE` | `#0891B2` | Info, low priority |
| `success` | `#22C55E` | `#16A34A` | Done, saved |
| `warning` | `#F5A524` | `#D97706` | Due today, medium priority, offline |
| `error` | `#F43F5E` | `#E11D48` | Overdue, high priority, delete |
| `scrim` | black 60% | `#0F0F1A` 40% | Behind sheets and dialogs |

`AccentColors.values` holds six theme-independent accents for tags (the example uses them for task categories, by index).

Contrast follows WCAG AA: body text on `background`/`surface` is above 7:1 in both themes, `textSecondary` above 4.5:1.

## Typography

Two bundled fonts (SIL Open Font License, in `assets/fonts/`):

- **Plus Jakarta Sans** for display and headings.
- **Inter** for body, labels and numbers, with tabular figures for numbers that change.

| Style (`context.text.*`) | Font | Size / line height | Weight | Use |
| --- | --- | --- | --- | --- |
| `display` | Jakarta | 32 / 40 | 800 | Hero titles (login, onboarding) |
| `screenTitle` | Jakarta | 28 / 34 | 700 | Screen headers |
| `title` | Jakarta | 22 / 28 | 700 | Dialog and card titles |
| `headline` | Jakarta | 18 / 24 | 700 | Section headers |
| `body` | Inter | 15 / 22 | 400 | Body text |
| `bodyStrong` | Inter | 15 / 22 | 600 | Emphasis, button labels |
| `label` | Inter | 13 / 18 | 500 | Chips, metadata |
| `caption` | Inter | 12 / 16 | 500 | Tags, timestamps |
| `numeric` | Inter tabular | 13 / 18 | 600 | Counts, percentages |

Use `copyWith(color: ...)` on a token style; never construct a raw `TextStyle`. Long text always gets `maxLines` + ellipsis.

## Spacing, Radius, Motion

- **Spacing** (`AppSpacing`): 4pt grid, `xs 4`, `sm 8`, `md 12`, `lg 16`, `xl 24`, `xxl 32`, `xxxl 48`. Screen side padding 16 on phones, 24 wider; content capped at `maxContentWidth` (760).
- **Radius** (`AppRadius`): `sm 8` (tags), `md 12` (inputs, buttons), `lg 16` (cards), `xl 24` (sheets, dialogs), `pill`.
- **Elevation:** no heavy shadows; the primary button has a soft violet glow. Floating chrome (bottom bar) uses a backdrop blur over `surface` at ~80%.
- **Motion** (`AppMotion`): `fast` 150 ms (press, chips), `normal` 250 ms (tabs, sheets), `slow` 400 ms (emphasised). Progress animates between values. When `MediaQuery.disableAnimations` is on, motion drops to instant.

## Iconography

Material Symbols **Rounded** (`material_symbols_icons`, `Symbols.*_rounded`), filled for the selected state. Sizes 20 inline, 24 default. Icon-only buttons always have a label (tooltip + semantics) from the message catalog.

## App Icon and Splash

- **App icon:** a clay-style checkbox with a white check on the Aurora gradient. Sources in `assets/icon/` (1024×1024): `app_icon.png` (iOS, Android legacy, Web), `app_icon_background.png` + `app_icon_foreground.png` (Android adaptive, `adaptive_icon_foreground_inset: 0`, so the foreground art itself stays inside the central 66% safe zone), `app_icon_monochrome.png` (Android 13+ themed icon: one flat colour, with a gap cut around the check so it still reads).
- **Native splash:** shows `assets/icon/splash.png` (768×768, the rounded icon) on the `background` colour, `#F7F7FB` light / `#0B0B12` dark. Android 12+ uses `splash_android12.png` (1152×1152; the system masks a centred circle 2/3 that size, so the art sits inside it). Web gets the same splash in `web/index.html`. The web manifest uses `#F7F7FB` / `#6A4CF5` (Aurora violet).
- The native splash is separate from the in-app `Splash` screen (`ui/features/startup/`), which takes over once Flutter draws its first frame.
- If the `background` tokens or the Aurora colours change, update the hex values in the `flutter_launcher_icons` (web) and `flutter_native_splash` configs in `pubspec.yaml` to match, then regenerate: see [Development](../architecture/development.md#app-icon-and-splash).

## Layout and Navigation

| Width | Layout |
| --- | --- |
| < 600 (phones) | Floating blurred bottom bar, single column |
| 600–839 | Bottom bar, wider content |
| ≥ 840 | Left sidebar with labels; content capped at 760 |

`ScreenScrollView` gives every screen its safe area, side padding by breakpoint, readable width, room for the floating bar, optional pull-to-refresh and an optional pinned bottom action.

## Components

All under `lib/ui/core/ui/base/<category>/`, plain props only, one widget per file.

| Category | Widgets |
| --- | --- |
| `buttons/` | `GradientButton` (primary), `TonalButton` (secondary, destructive variant), `GhostButton` (tertiary), `AppIconButton` (40px circle, 48px tap target, required label) |
| `cards/` | `AppCard` (surface card, optional tap), `StatTile` (number over label) |
| `chips/` | `SelectChip` (selectable pill, Aurora when selected), `ChipRow` (scrolling row or wrap) |
| `form/` | `AppTextField` (label, hint, icon, error from state, trailing), `AppCheckbox` (round Aurora check), `SegmentedPicker` (+ `SegmentedPickerLabel`), `AppSwitchTile` |
| `avatar/` | `UserAvatar` (photo bytes → network image → initials on Aurora) |
| `badges/` | `CountBadge` (unread count), `TagChip` (tinted read-only tag) |
| `progress/` | `GradientProgressBar` (animated, indeterminate), `ProgressRing` (Aurora ring) |
| `sheets/` | `AppBottomSheet` (+ pinned bottom action), `ActionSheet` (icon + label actions) |
| `dialog/` | `ConfirmDialog` / `showConfirmDialog` (destructive variant) |
| `states/` | `EmptyState`, `ErrorState` (with Retry), `ShimmerBox` (loading placeholder) |
| `layout/` | `ScreenScrollView`, `PinnedActionBar`, `ScreenHeader`, `ScreenBackButton`, `AuroraGlow`, `OfflineBanner` |
| `icons/` | `GradientIconTile` (Aurora icon on a tinted square) |
| `text/` | `SectionHeader` (title + trailing), `InfoRow` (label/value) |

**Pinned primary actions.** A screen's main button (Save, Mark as done) never scrolls away: pass it as `bottomAction` to `ScreenScrollView` / `AppBottomSheet`.

**Toasts.** `ToastUtil` (on `flutter_sliding_toast`) slides toasts in at the top, coloured by kind (info `primary`, `success`, `warning`, `error`), max 4 lines, 2.5 s, and skips a repeat of the toast still showing. Views call it (usually via `ref.listenMessages`); Notifiers never do.

## Accessibility

- Touch targets at least 44–48px.
- Text scales without clipping: rows wrap, cards grow.
- Every icon-only control has a semantic label from the catalog.
- Colour is never the only signal: priority has an icon and label, overdue has text, done is struck through.

## Code Structure

```
lib/ui/core/themes/
  app_colors.dart        # AppColors ThemeExtension (dark + light), AccentColors
  app_gradients.dart     # Aurora
  app_typography.dart    # AppTypography ThemeExtension
  app_spacing.dart       # AppSpacing + AppRadius
  app_motion.dart        # durations + curves
  theme_data.dart        # buildTheme(Brightness) -> ThemeData (Material 3)
  theme.dart             # context.colors, context.text, context.isDark
```

`ThemeData` is Material 3 (`material_ui`), with the `ColorScheme`, dialog, sheet, switch and text-selection themes filled from the tokens so stock widgets (date/time pickers, menus, switches) match without extra styling.

To rebrand, change the three Aurora stops and the token tables in `app_colors.dart` / `app_gradients.dart`, swap the fonts in `pubspec.yaml` + `app_typography.dart`, and update this doc (the `fresh-start` skill can do it).
