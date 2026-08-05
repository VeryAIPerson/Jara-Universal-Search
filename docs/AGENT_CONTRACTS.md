# Agent Contracts — screen implementation rules

Binding contract for every screen-implementation agent. The foundation is
committed; you build ONLY inside your assigned `lib/features/<x>/` files by
REPLACING the stubs. Integration must be mechanical.

## Hard rules

1. **File ownership.** Touch only your assigned files. Never edit `lib/core/`,
   `lib/l10n/`, `pubspec.yaml`, other features, or docs. If a core API blocks
   you, note it in your final report — do not patch core.
2. **Use the design system.** No raw `Container` cards, no ad-hoc colors,
   no `Colors.*` except `Colors.white`/`Colors.transparent` where core widgets
   already do. Every color via `context.jara` (import
   `core/design/jara_theme.dart`), every text style via `JaraType`, spacing via
   `JaraSpacing`, radii via `JaraRadius`, durations via `JaraMotion`.
3. **Strings.** `final s = ref.strings;` (import `core/l10n_bridge.dart`,
   screens are `ConsumerWidget`/`ConsumerStatefulWidget`). Only keys existing in
   `lib/l10n/strings.dart`. Missing key → English literal + `// l10n-todo`.
4. **Accessibility.** Interactive elements get semantic labels (core widgets
   have `semanticLabel` params — use them). Touch targets ≥44.
5. **No new dependencies.** flutter_riverpod, go_router, flutter/material only.
6. **Navigation.** `context.go`/`context.push` with routes listed below. Never
   construct screens directly.
7. **Verify.** Run `PATH=/opt/flutter/bin:$PATH flutter analyze` before
   finishing; your files must contribute 0 errors AND 0 warnings/infos.
8. Comments: sparse, only non-obvious constraints. Match core code style.

## Routes

`/splash` · `/onboarding` · `/search` (shell tab0) · `/search/results?q=<query>`
· `/memory` (tab1) · `/collections` (tab2) · `/collections/:id` ·
`/profile` (tab3) · `/profile/connections` · `/profile/privacy` ·
`/item/:id` (detail, outside shell) · `/share-capture` (standalone demo).
Add flow is NOT a route: `showAddSheet(context)` from
`features/add/add_sheet.dart` (owned by W3).

Shell pages (tabs) are wrapped by `JaraShell` (bottom bar + FAB) — your tab
screens must NOT add their own Scaffold bottomNavigationBar; body content must
end with bottom padding ≥120 (shell bar floats over content,
`surfacePadding` default in HorizonScaffold already handles it).

## Core API (source of truth: lib/core/…)

Tokens/theme:
- `context.jara` → JaraTokens: `.skyTop .skyBottom .surface .surfaceElevated
  .tile .tileOnSky .textPrimary .textSecondary .textTertiary .textOnSky
  .textOnSkySecondary .textOnSkyTertiary .accent .accentBright .violet .gold
  .border .borderOnSky .success .warning .error .scrim .isDark
  .skyGradient .accentGradient .neuShadows .accentGlow`
- `JaraType.display .title1 .title2 .headline .body .bodyMedium .callout
  .subhead .footnote .footnoteMedium .caption .label .button`
- `JaraSpacing.xs sm md lg xl xxl xxxl huge page` · `JaraRadius.chip field
  card tile sheet bar` · `JaraSize.touchMin searchFieldHeight fab bottomBar`
- `JaraMotion.instant fast base gentle slow standard emphasized enter spring
  stagger` + `JaraMotion.of(context, d)` (reduce-motion aware)
- `JaraHaptics.tap() select() confirm() heavy()`

Widgets (constructors abbreviated to key params):
- `HorizonScaffold({required Widget sky, required Widget surface,
  bool inverted, EdgeInsets skyPadding, EdgeInsets surfacePadding,
  ScrollController? controller})`
- `NotchAppBar({IconData? leadingIcon, VoidCallback? onLeadingTap,
  String? leadingSemanticLabel, IconData? trailingIcon, VoidCallback?
  onTrailingTap, String? trailingSemanticLabel, String avatarInitials,
  VoidCallback? onAvatarTap})`
- `PrivacyPill({required String label, bool active, VoidCallback? onTap})`
- `JaraSearchField({controller, focusNode, List<String> hints,
  onSubmitted, onChanged, onVoiceTap, onFilterTap, onTap, readOnly,
  autofocus, hero})` — hero:true glides between home/results (keep default
  on both).
- `FilterChipRow({required MemoryType? selected, required
  ValueChanged<MemoryType?> onSelected, required String allLabel, required
  String Function(MemoryType) labelOf, bool onSky, List<MemoryType> types})`
- `SearchFilterChip / JaraChip({label, icon, color, onTap})`
- `NeuTile({required IconData icon, required Color iconColor, required
  String label, String? meta, VoidCallback? onTap, String? badge})`
- `NeuIconButton({required icon, required onTap, bool onSky, double size,
  Color? iconColor, String? semanticLabel})`
- `NeuCard({required child, onTap, onLongPress, bool onSky,
  EdgeInsetsGeometry padding, double radius, String? semanticLabel})`
- `SectionHeader({required title, String? actionLabel, VoidCallback?
  onAction, bool onSky})`
- `MemoryStatusCard({required MemoryStats stats, required String title,
  required String itemsLabel, required String freeLabel, required String
  lastIndexedLabel, VoidCallback? onTap})`
- `SmartSummaryCard({required SmartSummary summary, required titleLabel,
  required basedOnLabel, required viewSourcesLabel, onViewSources, onCopy,
  onSave})` + `SmartSummarySkeleton()`
- `UniversalResultCard({required MemoryItem item, String query,
  VoidCallback? onTap, VoidCallback? onPin, bool onSky, String? dateLabel})`
- `TimelineRail({required List<DateTime> days, required DateTime selected,
  required ValueChanged<DateTime> onSelect, Map<DateTime,int> counts,
  double height})` — counts keys must be date-only `DateTime(y,m,d)`.
- `EmptyStateView({required icon, required title, required message,
  primaryLabel, onPrimary, secondaryLabel, onSecondary, onSky, compact})`
- `JaraButton({required label, required onTap, bool expanded, bool gold,
  IconData? icon})` · `JaraSoftButton({required label, required onTap,
  IconData? icon, bool onSky, bool expanded})`
- `OfflineBanner({required label})` · `StaggeredItem({required index,
  required child})` · `Shimmer / SkeletonLine({width,height}) /
  SkeletonCard({height})`
- `Pressable({required child, onTap, onLongPress, semanticLabel})`
- `highlightSpans(text, query, {required style, required highlightStyle})`
  → InlineSpan (already used inside UniversalResultCard).

Data (import `core/data/providers.dart`, models via
`core/models/memory_item.dart`):
- `memoryRepositoryProvider` → MockMemoryRepository: `.all
  .recentlySaved(limit) .pinned() .byId(id) .togglePin(id) .remove(id)
  .add(item) .countOf(type) .ofType(type) .inCollection(id)
  .related(item) .search(q, filter:) .suggest(prefix) .stats()
  .collections .connections .recentSearches`
- `searchQueryProvider` (StateProvider<String>) — set then read
  `searchResultsProvider` (FutureProvider<SearchOutcome>, 260 ms simulated).
- `activeFilterProvider` (StateProvider<MemoryType?>) ·
  `suggestionsProvider(prefix)` · `memoryStatsProvider` ·
  `memoryRevisionProvider` (bump after pin/delete/add to refresh lists) ·
  `privacyTierProvider` (PrivacyTier.localOnly/hybrid) · `offlineProvider` ·
  `indexStateProvider` · `themeModeProvider` · `localeProvider`.
- Strings: `ref.strings` → JaraStrings (all keys in lib/l10n/strings.dart);
  `relativeDate(s, date)` for "2d ago" labels.
- Models: MemoryItem(type/title/snippet/source/date/tags/people/collection/
  extLabel/sizeLabel/pageLabel/location/timeLabel/matchReason/pinned),
  MemoryType(.color/.icon), MemoryCollection, SearchSuggestion(kind/text/
  subtitle/type), SmartSummary, SearchOutcome(items/elapsed/summary/grouped),
  ConnectionInfo(status…), MemoryStats.

## Composition guide

Every tab screen = `HorizonScaffold`. Sky content order (home): NotchAppBar →
greeting/title → JaraSearchField → chips/status. Surface: SectionHeader +
grids/lists. Detail-style pushed screens may use a plain Scaffold with
`t.surface` bg and a simple back header (`NeuIconButton` chevron) — keep the
sky treatment for tab roots and results.
