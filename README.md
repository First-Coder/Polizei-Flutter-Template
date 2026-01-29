# Polizei Flutter Template (Berlin) – `police_flutter_template`

*<code style="color : red">Projekt ist noch in der frühen Entwicklungsphase</code>*

Ein **Flutter-Projekt-Template** für Anwendungen im Kontext der **Berliner Polizei**: konsistentes Layout- und Navigationskonzept, Theme-/Design-Grundlagen, Fehlerseiten, Logging, Dependency Injection sowie eine klare Projektstruktur (BLoC/Cubit, Routing, Screens, Widgets).

> Hinweis: Dieses Repository ist ein technisches Template. Verwenden Sie Logos, Wappen, Namen und Corporate-Design-Elemente nur, wenn Sie dazu berechtigt sind.

---

## Inhalt

- [Ziele & Scope](#ziele--scope)
- [Features (Template-Umfang)](#features-template-umfang)
- [Technologie-Stack](#technologie-stack)
- [Projektstruktur](#projektstruktur)
- [Schnellstart](#schnellstart)
- [Konfiguration](#konfiguration)
    - [App-Konstanten](#app-konstanten)
    - [Navigation & Routing](#navigation--routing)
    - [Theme / Dark Mode](#theme--dark-mode)
    - [Fehlerseiten](#fehlerseiten)
    - [Authentifizierung (Grundgerüst)](#authentifizierung-grundgerüst)
    - [Logging](#logging)
    - [Dependency Injection](#dependency-injection)
    - [Assets & Branding](#assets--branding)
- [Arbeitsabläufe](#arbeitsabläufe)
    - [Neue Seite hinzufügen](#neue-seite-hinzufügen)
    - [Neuen API-Call hinzufügen](#neuen-api-call-hinzufügen)
    - [Fehlerzustände sauber behandeln](#fehlerzustände-sauber-behandeln)
- [Qualität](#qualität)
    - [Linting & Analyse](#linting--analyse)
    - [Tests](#tests)
- [Build & Release](#build--release)
- [Sicherheit & Datenschutz](#sicherheit--datenschutz)
- [Troubleshooting](#troubleshooting)
- [Contributing](#contributing)
- [Lizenz](#lizenz)

---

## Ziele & Scope

Dieses Template soll:

- einen **schnellen Projektstart** ermöglichen (Layouts, Routing, State-Management, Logging),
- einheitliche **UI-/UX-Grundlagen** liefern (z. B. wiederverwendbare Widgets, responsive Layouts),
- typische App-Bausteine (Auth-Shell, Fehlerseiten, Navigation, Footer) **vorkonfigurieren**,
- Teams eine **skalierbare Struktur** geben, ohne sich früh festzufahren.

Nicht im Scope (absichtlich offen gelassen):

- eine produktionsfertige Auth-Anbindung (OAuth2/OIDC, SSO, PKI),
- Backend-/Domain-spezifische Logik,
- vollständige CI/CD-Pipelines (kann ergänzt werden).

---

## Features (Template-Umfang)

### Architektur & Struktur
- **BLoC/Cubit**-Struktur für Zustandsverwaltung (skalierbar, testbar)
- **Feature-orientierte Ordnerstruktur** (Screens, Widgets, Settings, Theme, Routes)
- Erweiterungen/Utilities (Extensions) zur UI-Ergonomie

### Navigation & Layout
- Zentralisiertes Routing mit **`go_router`**
- Layout-System mit wiederverwendbaren Layout-Widgets (z. B. Main-/Full-Screen-Layouts)
- Responsive Hilfen (für Web/Desktop/Mobile)

### UI / UX
- Komponenten/Widgets als Baukasten (Buttons, Icon-Container etc.)
- Vorbereitete **Fehlerseiten** (z. B. 404, Not Authorized)
- SVG-Unterstützung (z. B. Behörden-/Branding-Grafiken)

### Observability
- Zentrales Logging mit **Talker**
- BLoC-Observer-Logging (Events/Transitions)
- (Optional erweiterbar) HTTP-Logging für Dio

### Security Basics (App-Seite)
- Secure Storage als Basis für Token/Secrets (plattformabhängig)
- Strukturierte Stellen für Auth-Init-/Startup-Tasks

---

## Technologie-Stack

- **Flutter** (aktueller Stable-Channel empfohlen)
- **State Management**: `flutter_bloc`, `equatable`
- **Routing**: `go_router`
- **Networking**: `dio`
- **Dependency Injection**: `get_it`
- **Secure Storage**: `flutter_secure_storage`
- **Logging/Observability**: `talker_flutter`, `talker_bloc_logger`, `talker_dio_logger`
- **UI**: `shadcn_flutter`, `flutter_svg`, `flutter_animate`, `flutter_spinkit`
- **Sonstiges**: `intl`, `url_launcher`, `package_info_plus`

---

## Projektstruktur

Ein Überblick über die wichtigsten Verzeichnisse:

- `lib/`
    - `main.dart` – Einstieg, Setup von Logging & DI, `runApp(...)`
    - `screens/` – UI-Seiten & app-nahe Widgets
        - `app.dart` – App-Wurzel (MaterialApp/Router/Theme-Anbindung)
        - `error_pages/` – Fehlerseiten (404/Unauthorized)
        - `home/` – Start-/Home-Bereich
        - `widgets/` – wiederverwendbare UI-Bausteine und Layouts
    - `routes/` – Routing-Konfiguration, Namen, Router-Cubit
    - `bloc/` – BLoCs (z. B. Auth)
    - `theme/` – Theme-Cubit/State
    - `settings/` – zentralisierte Konfiguration (Navigation, Footer, Errors, Konstanten, etc.)
    - `extensions/` – hilfreiche Extensions (Text/Widget-Helpers, Animation Wrapper, etc.)
    - `logs/` – strukturierte Log-Modelle (z. B. Routings)

- `assets/`
    - z. B. `assets/logo/` – Branding-Assets (SVG)

- Plattformen: `android/`, `ios/`, `web/`, `macos/`
- `test/` – Widget-/Unit-Tests

---

## Schnellstart

### Voraussetzungen
- Flutter SDK installiert (`flutter --version`)
- Abhängigkeiten verfügbar:
    - Android: Android Studio + SDKs
    - iOS/macOS: Xcode + CocoaPods
    - Web: Chrome/Edge

### Setup

1. Repository klonen und ins Projektverzeichnis wechseln:
    ```
    git clone https://github.com/First-Coder/Polizei-Flutter-Template.git cd police_flutter_template
    ```
2. Flutter-Umgebung prüfen (zeigt fehlende Tools/SDKs an):
    ```
    flutter doctor
    ```
3. Abhängigkeiten installieren:
    ```
    flutter pub get
    ```
4. (Empfohlen) Projekt einmal sauber aufsetzen, falls es zuvor gebaut wurde:
    ```
    flutter clean flutter pub get
    ```
5. App starten (je nach Zielplattform):
   - Android (Device/Emulator):
       ```
       flutter run
       ```
   - Web (Chrome):
       ```
       flutter run -d chrome
       ```
   - macOS:
       ```
       flutter run -d macos
       ```

---

## Konfiguration

### App-Konstanten

Zentrale Konstanten/Flags/Defaults liegen in `lib/settings/` (z. B. `app_constants.dart`).
Empfehlung: alle “globalen” App-Parameter dort bündeln (App-Name, URLs, Feature-Flags).

**Best Practice:**
- `AppConstants.baseUrl` (je Umgebung)
- `AppConstants.appTitle` (je Flavor)
- `AppConstants.supportEmail` / `Impressum`-Links

### Navigation & Routing

Die Routen sind in `lib/routes/` strukturiert:

- `route_names.dart` – stabile Routennamen (für `pushNamed`)
- `route_config.dart` – GoRouter-Konfiguration
- optional: `routes/cubit/` – Router-State für globale Navigation/Guards

**Empfehlungen:**
- Verwenden Sie **benannte Routen** für Stabilität.
- Implementieren Sie **Guards** (Auth/Role) zentral im Router, nicht in Screens.

### Theme / Dark Mode

Theme ist in `lib/theme/` organisiert:

- `theme_cubit.dart` / `theme_state.dart`

**Empfehlungen:**
- Farben/Typografie zentral definieren (und nur referenzieren)
- Dark-Mode per Cubit toggeln
- UI-Komponenten sollten “theme-aware” sein (keine hardcodierten Farben)

### Fehlerseiten

Fehlerseiten liegen unter `lib/screens/error_pages/` sowie ggf. Karten/Widgets unter `lib/screens/widgets/error_pages/`.

Typische Anwendungsfälle:
- 404 Route not found
- Unauthorized/Forbidden (Rollen-/Rechteproblem)
- “Service nicht verfügbar” (Backend down)

**Empfehlung:**
- Nutzen Sie zentrale `ErrorSettings`, um Texte/Links/Reason-Listen konsistent zu halten.
- Verlinken Sie aus Fehlerseiten immer zurück zur Startseite oder zu einem sicheren Einstieg.

### Authentifizierung (Grundgerüst)

Unter `lib/bloc/auth/` ist das Auth-Grundgerüst vorbereitet:

- `auth_bloc.dart`, `auth_event.dart`, `auth_state.dart`
- Modelle unter `models/`

Zusätzlich gibt es in `lib/settings/auth_init_tasks.dart` einen Ort für Start-/Init-Aufgaben.

**Empfehlung für produktive Auth:**
- Tokens in Secure Storage
- Refresh-/Expiry-Strategie
- Router-Guard basierend auf Auth-State
- Trennung: `AuthRepository` (Daten), `AuthBloc` (State), `UI` (Screens)

### Logging

Logging ist über **Talker** vorbereitet und wird beim App-Start registriert.

Ziele:
- nachvollziehbare Navigation (Routen-Logs)
- BLoC-Transitions/Events sichtbar
- HTTP-Calls bei Bedarf protokollieren (mit `talker_dio_logger`)

**Best Practice:**
- Keine sensiblen Daten loggen (Tokens, PII)!
- Log-Level je Flavor (Debug ausführlich, Release minimal)

### Dependency Injection

DI erfolgt über `get_it`. Beim Start werden Singletons registriert.

**Empfehlungen:**
- `registerSingleton` für Logger/Config
- `registerLazySingleton` für Repos/Services
- klare “Composition Root” im Startup (z. B. `main.dart`)

### Assets & Branding

Assets sind im `pubspec.yaml` eingebunden (z. B. `assets/logo/`).

**Empfehlungen:**
- Logos/Wappen rechtssicher verwenden
- Branding austauschbar halten (z. B. `assets/logo/agency_logo.svg`)
- Für Web: Favicon/Manifest entsprechend anpassen (`web/`)

---

## Arbeitsabläufe

### Neue Seite hinzufügen

1. Screen anlegen: `lib/screens/<feature>/<name>_screen.dart`
2. Route-Name hinzufügen: `lib/routes/route_names.dart`
3. Route konfigurieren: `lib/routes/route_config.dart`
4. Optional: Navigationseintrag in `lib/settings/navigation_items.dart`

### Neuen API-Call hinzufügen

Empfohlenes Muster:
- `lib/<feature>/data/<feature>_api.dart` (Dio Client)
- `lib/<feature>/data/<feature>_repository.dart`
- `lib/<feature>/bloc/<feature>_bloc.dart`

So bleibt UI frei von Netzwerkdetails.

### Fehlerzustände sauber behandeln

- Fehler im Repository fangen und in **Domänenfehler** übersetzen
- BLoC State: `loading/success/failure`
- UI reagiert deterministisch:
    - Loader (z. B. Spinner)
    - Fehlerkarte/Fehlerseite mit Handlung (Retry, Home, Kontakt)

---

## Qualität

### Linting & Analyse

- Lints: `flutter_lints`
- Ausführen:
```
flutter analyze
```

### Tests
Tests liegen unter `test/`.

Empfohlene Test-Pyramide:
- Unit-Tests: Cubits/BLoCs, Repositories
- Widget-Tests: Seitenzustände (Loading/Empty/Error)
- (Optional) Integration-Tests: kritische Flows (Login → Home)

Ausführen:  
```
  flutter test
```

---

## Build & Release

### Web Build
```
flutter build web
```

### Android APK/AAB
```
flutter build apk flutter build appbundle
```

### iOS
```
flutter build ios
```

> Tipp: Für CI/CD empfehlen sich Flavors (dev/stage/prod) + getrennte Base-URLs und Log-Level.

---

## Sicherheit & Datenschutz

Dieses Template unterstützt eine saubere Struktur, ersetzt aber keine Security-Architektur.

**Empfehlungen:**
- Keine Secrets im Repo (auch nicht in `assets/`)
- Tokens nur in Secure Storage, niemals in Logs
- DSGVO/Datenschutz: Logging minimieren, PII anonymisieren/pseudonymisieren
- Für produktive Behördenkontexte: Threat Modeling, PenTests, sichere Konfigurationen je Plattform

---

## Troubleshooting

**`flutter pub get` schlägt fehl**
- Prüfen: Flutter SDK Version
- `flutter clean && flutter pub get`

**iOS CocoaPods Probleme**
- `cd ios && pod repo update && pod install && cd ..`

**Web Routing (404 bei Refresh)**
- Bei Hosting ggf. Rewrite-Regeln setzen (alle Routen auf `index.html`)

---

## Contributing

Vorschlag für Team-Workflow:
- Branching: `feature/*`, `fix/*`
- Code-Style: `dart format .`
- PR-Checks: `flutter analyze`, `flutter test`

---

## Lizenz

Dieses Projekt ist lizenziert unter der **GNU General Public License v3.0 (GPL-3.0)**.

- Lizenztext: https://www.gnu.org/licenses/gpl-3.0.html
- Kurzüberblick: https://www.gnu.org/licenses/quick-guide-gplv3.html

> Hinweis: Wenn Sie dieses Projekt (oder abgeleitete Werke) verteilen, müssen Sie die Bedingungen der GPL-3.0 einhalten (u. a. Bereitstellung des Quellcodes und Beibehaltung der Lizenzhinweise).