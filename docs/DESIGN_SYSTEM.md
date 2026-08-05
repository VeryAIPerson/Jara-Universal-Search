# Lamplight Design System — JARA Universal Search

English engineering spec. Token source of truth: `lib/core/design/`.
Product rationale + Turkish brief: `DESIGN_BRIEF_TR.md`. Widget API:
`AGENT_CONTRACTS.md`.

## 1. Structure — the Horizon signature

Every root screen splits into two hemispheres separated by an asymmetric
S-curve (`JaraWaveClipper`: left drop 44, right drop 86, cubic pair):

| Hemisphere | Role | Dark theme | Light theme |
|---|---|---|---|
| Memory sky (top) | Command: greeting, search, status | `#0D1220 → #080A0F` | same (sky stays dark) |
| Surface (bottom) | Content: tiles, cards, lists | `#11141C` | `#E9ECF5` lavender mist |

Memory screen inverts the split (`HorizonScaffold(inverted: true)`).
Signature elements: notched avatar app bar, neumorphic source tiles,
center Add FAB (64, gradient, morphs add→sync→success), timeline rail,
MyMemory status card.

## 2. Color

Accent electric indigo `#5B7CFA` → violet `#836BFF` (gradient 135°).
Secondary sky-kin `#7AA8FF` (info tints only). Gold `#D4AF6E`
(light `#A98530`) strictly for brand moments: Smart Summary seal, pin,
Premium, wordmark. Status: success `#4CC38A`, warning `#E8B04B`, error
`#E5595E`. Source-type hues in `JaraPalette.src*` (one soft hue per
content source, used at 14–16% alpha behind icons).

Neumorphic shadows — light theme: dark `#A6B1D2@55%` offset(6,7)/blur 18 +
white offset(−6,−6)/blur 16. Dark theme: black@45% offset(5,6)/blur 16 +
white@3% offset(−3,−3)/blur 10. Accent glow: accent@45%/blur 24/dy 8.

## 3. Type — Inter variable (bundled)

display 34/700/−0.5 · title1 28/700 · title2 22/600 · headline 17/600 ·
body 16/400/1.45 · bodyMedium 16/500 · callout 15/500 · subhead 14/400 ·
footnote 13/400 · footnoteMedium 13/500 · caption 11/500 · label
11/600/+0.8 (uppercase section headers) · button 16/600.
Variable-font weights require paired `FontVariation('wght', …)` — handled
in `JaraType`, never hand-roll TextStyles.

## 4. Geometry

Spacing 4-grid: 4/8/12/16/20/24/32/40, page inset 20. Radii: chip 12,
field 22, card 20, tile 26, sheet 28, bar 28, FAB circle. Sizes: touch
min 44, search field 58, FAB 64, bottom bar 72, avatar notch 52.

## 5. Motion & haptics

80/120/200/320/480 ms; standard `easeOutCubic`, enter `easeOutQuart`,
spring `easeOutBack`; result stagger 40 ms/card (cap 8). All through
`JaraMotion.of(context, d)` → zero under Reduce Motion. Haptics: tap
light · select (chips, timeline) · confirm medium (save/pin) · heavy
(destructive). Never haptic on scroll.

Signature micro-moments: search focus = border accent + soft glow (200 ms);
hint rotation fade/slide 3.6 s cycle; FAB success = gold flash ring;
summary loading = calm shimmer (1.6 s sweep); wave scroll parallax —
deferred to v1.1 (perf budget first).

## 6. Components

See `AGENT_CONTRACTS.md` for full constructor list. Composition rules:
cards never nest neu-shadows (one shadow level per surface); sky panels
use flat elevated fills (`tileOnSky`) instead of neu shadows; max one
gold element per screen; accent gradient only on primary action + selected
states.

## 7. States

Empty/error via `EmptyStateView` (soft icon ring + title + message + ≤2
CTAs). Offline via `OfflineBanner` — search keeps working local-first;
cloud-dependent actions show a small cloud-off glyph. Loading: skeletons
(`SkeletonCard`/`SmartSummarySkeleton`), never blocking spinners on
results.

## 8. Platform

iOS: Cupertino page transitions, SF-symbol-adjacent rounded icons,
contextual permission prompts. Android: FadeForwards transitions,
predictive back OK, Material ripple only inside bottom bar items.
Web target = design verification/demo only (D11).

## 9. Accessibility

Contrast pairs (AA+): textOnDark/void 17.9:1 · textOnDarkSecondary/surface
7.4:1 · ink/mist 13.7:1 · white/accent 4.6:1. Every interactive widget
takes/sets a semantic label; chips expose selected state; timeline exposes
day labels. Dynamic Type safe: no fixed-height text rows, tiles grow.
