import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Immutable model that represents a single entry in the app's navigation UI
/// (e.g. sidebar, drawer, or a menu list).
///
/// A [NavigationItem] can be:
/// - a **leaf item** that performs an action when selected (via [onPressed]), or
/// - a **group item** that contains nested entries (via [children]).
///
/// Typical usage patterns:
/// - **Internal navigation**: provide [onPressed] (e.g. `context.goNamed(...)`).
/// - **External navigation**: set [isExternal] to `true` and provide a [url]
///   (the UI decides how to open it).
///
/// Notes / conventions:
/// - [icon] is optional to allow text-only items.
/// - If [children] is not empty, the UI usually treats the item as expandable.
/// - This model intentionally does not hardcode routing concepts (route names/paths).
///   Those can live in [onPressed] (internal) or [url] (external).
class NavigationItem {
  /// Creates a navigation item.
  ///
  /// Required:
  /// - [title] is the label shown to the user.
  ///
  /// Optional:
  /// - [icon] is rendered next to the title (if provided).
  /// - [children] defines nested items (defaults to an empty list).
  /// - [isExternal] marks the item as pointing outside the app (defaults to `false`).
  /// - [url] can hold an external destination (typically used with [isExternal]).
  /// - [onPressed] is invoked when the item is selected.
  ///
  /// Recommended constraints (not enforced by code):
  /// - Prefer either [children] **or** [onPressed] for a given item.
  /// - If [isExternal] is `true`, provide a non-null [url].
  const NavigationItem({
    required this.title,
    this.icon,
    this.children = const [],
    this.isExternal = false,
    this.url,
    this.onPressed,
  });

  /// Visible label displayed in the navigation UI.
  final String title;

  /// Optional icon widget (e.g. `Icon(LucideIcons.home)`).
  final Widget? icon;

  /// Child entries for hierarchical navigation.
  ///
  /// If this list is non-empty, UIs typically render this item as a group/section.
  final List<NavigationItem> children;

  /// Whether the item should be treated as an external destination.
  ///
  /// The UI may show an "external link" indicator and open [url] in a browser.
  final bool isExternal;

  /// External destination URL.
  ///
  /// Typically used when [isExternal] is `true`.
  final String? url;

  /// Callback executed when the item is selected.
  ///
  /// For internal navigation this commonly triggers `go_router`, e.g.
  /// `() => context.goNamed(RouteNames.home)`.
  final VoidCallback? onPressed;
}