import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../../theme/cubit/theme_cubit.dart';

class ButtonThemes extends StatelessWidget {
  const ButtonThemes({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeCubit>().state.isDarkMode;
    return ComponentTheme(
      data: OutlineButtonTheme(
        decoration: (context, states, defaultDecoration) {
          if (states.contains(WidgetState.disabled)) {
            return defaultDecoration.copyWithIfBoxDecoration(
              color: isDark ? Colors.gray[500] : Colors.gray[200],
              border: Border.all(
                color: isDark ? Colors.gray[600] : Colors.gray[300],
              ),
            );
          } else if (states.contains(WidgetState.hovered)) {
            return defaultDecoration.copyWithIfBoxDecoration(
              color: isDark ? Colors.gray[600] : Colors.gray[200],
              border: Border.all(
                color: isDark ? Colors.blue[300] : Colors.blue[600],
              ),
            );
          } else {
            return defaultDecoration.copyWithIfBoxDecoration(
              color: isDark
                  ? Colors.gray.withAlpha(0)
                  : Colors.white.withAlpha(0),
              border: Border.all(
                color: isDark ? Colors.gray[200] : Colors.blue[900],
              ),
            );
          }
        },
        textStyle: (context, states, defaultTextStyle) {
          return defaultTextStyle.copyWith(
            color: isDark ? Colors.gray[200] : Colors.blue[900],
          );
        },
        iconTheme: (context, states, defaultIconTheme) {
          return defaultIconTheme.copyWith(
            color: isDark ? Colors.gray[200] : Colors.blue[900],
          );
        },
      ),
      child: ComponentTheme(
        data: SecondaryButtonTheme(
          decoration: (context, states, defaultDecoration) {
            if (states.contains(WidgetState.disabled)) {
              return defaultDecoration.copyWithIfBoxDecoration(
                color: isDark ? Colors.gray[500] : Colors.gray[200],
              );
            } else if (states.contains(WidgetState.hovered)) {
              return defaultDecoration.copyWithIfBoxDecoration(
                color: isDark ? Colors.gray[300] : Colors.gray[200],
              );
            } else {
              return defaultDecoration.copyWithIfBoxDecoration(
                color: isDark ? Colors.gray[400] : Colors.gray[100],
              );
            }
          },
          textStyle: (context, states, defaultTextStyle) {
            return defaultTextStyle.copyWith(
              color: isDark ? Colors.black : Colors.blue[900],
            );
          },
          iconTheme: (context, states, defaultIconTheme) {
            return defaultIconTheme.copyWith(
              color: isDark ? Colors.black : Colors.blue[900],
            );
          },
        ),
        child: ComponentTheme(
          data: GhostButtonTheme(
            decoration: (context, states, defaultDecoration) {
              if (states.contains(WidgetState.hovered)) {
                return defaultDecoration.copyWithIfBoxDecoration(
                  color: isDark ? Colors.gray[600] : Colors.gray[200],
                );
              }
              return defaultDecoration;
            },
            textStyle: (context, states, defaultTextStyle) {
              if (states.contains(WidgetState.disabled)) {
                return defaultTextStyle.copyWith(
                  color: isDark ? Colors.gray[300] : Colors.gray[600],
                );
              } else {
                return defaultTextStyle.copyWith(
                  color: isDark ? Colors.gray[300] : Colors.blue[900],
                );
              }
            },
            iconTheme: (context, states, defaultIconTheme) {
              if (states.contains(WidgetState.disabled)) {
                return defaultIconTheme.copyWith(
                  color: isDark ? Colors.gray[300] : Colors.gray[600],
                );
              } else {
                return defaultIconTheme.copyWith(
                  color: isDark ? Colors.gray[300] : Colors.blue[900],
                );
              }
            },
          ),
          child: ComponentTheme(
            data: DestructiveButtonTheme(
              decoration: (context, states, defaultDecoration) {
                if (states.contains(WidgetState.disabled)) {
                  return defaultDecoration.copyWithIfBoxDecoration(
                    color: Colors.red[500],
                  );
                } else if (states.contains(WidgetState.hovered)) {
                  return defaultDecoration.copyWithIfBoxDecoration(
                    color: Colors.red[700],
                    border: Border.all(color: Colors.red[600]),
                  );
                } else {
                  return defaultDecoration.copyWithIfBoxDecoration(
                    color: Colors.red[500],
                    border: Border.all(color: Colors.red[600]),
                  );
                }
              },
              textStyle: (context, states, defaultTextStyle) {
                return defaultTextStyle.copyWith(color: Colors.gray[100]);
              },
              iconTheme: (context, states, defaultIconTheme) {
                return defaultIconTheme.copyWith(color: Colors.gray[100]);
              },
            ),
            child: ComponentTheme(
              data: LinkButtonTheme(
                textStyle: (context, states, defaultTextStyle) {
                  if (states.contains(WidgetState.disabled)) {
                    return defaultTextStyle.copyWith(
                      color: isDark ? Colors.gray[400] : Colors.gray[600],
                    );
                  } else {
                    return defaultTextStyle.copyWith(
                      color: isDark ? Colors.white : Colors.blue[900],
                    );
                  }
                },
                iconTheme: (context, states, defaultIconTheme) {
                  if (states.contains(WidgetState.disabled)) {
                    return defaultIconTheme.copyWith(
                      color: isDark ? Colors.gray[400] : Colors.gray[600],
                    );
                  } else {
                    return defaultIconTheme.copyWith(
                      color: isDark ? Colors.white : Colors.blue[900],
                    );
                  }
                },
              ),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
