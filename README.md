# Smart Post — Flutter Implementation

A single-screen Flutter UI built from the Oriflame *Smart Posts* Figma design: a
reels-style feed of AI-generated social posts, each with a product block, a
suggested track, an editable caption and a quick-share strip.

All data is hardcoded. There is no backend, no API layer and no URL launcher —
per the brief, this is a UI build meant to be demoed.

---

## Running it

```bash
flutter pub get
flutter run
```

Built against **Flutter 3.38 / Dart 3.x**. Run the tests with:

```bash
flutter test
flutter analyze   # clean, no issues
```

---

## Structure

```
lib/
├── main.dart                  entry point — runApp()
├── app.dart                   MaterialApp, theme, provider scope, routes
├── core/
│   ├── theme/                 colours, type, spacing, ThemeData
│   ├── constants/             every string and asset path
│   └── utils/                 responsive scaling helpers
├── data/
│   ├── models/                SmartPost, Product, MusicTrack, SharePlatform
│   └── mock/                  the hardcoded posts and share destinations
├── features/
│   ├── smart_post/            screen + controller + widgets
│   ├── generation/            the "Building personalised Smart Posts" overlay
│   └── edit_caption/          full-screen caption editor
├── shared/widgets/            widgets used by more than one feature
└── routes/                    named route table

assets/
├── images/                    post + product photos (see Assets below)
├── icons/
└── fonts/Satoshi/             (empty — see Typography below)

test/
└── widget/                    smoke tests for the feed screen
```

Three rules hold the structure together:

1. **One widget per file.** No file declares two public widgets.
2. **No literals in widget files.** Colours come from `AppColors`, sizes from
   `AppSpacing`/`AppSizes`, copy from `AppStrings`. A bare `16` or `#FFF` in a
   widget belongs in `core/theme`.
3. **`features/` is private, `shared/` is public.** A widget moves up to
   `shared/` the moment a second feature needs it.

State is a single `ChangeNotifier` (`SmartPostController`) exposed through
`provider`. For one screen with a handful of fields, anything heavier would be
ceremony — and swapping it out later touches only that one file.

---

## Design notes implemented

The canvas annotations were treated as the spec:

| Note on the canvas | Where it lives |
|---|---|
| "Show 3 posts — user can scroll like reels" | `post_feed.dart` — vertical snapping `PageView` |
| "Product info fades in from the bottom after 3 seconds" | `post_detail_panel.dart` — slide + fade, only on the visible card |
| "This whole box is clickable → personal beauty store" | `product_card.dart` |
| "This list is scrollable" | `quick_share_row.dart` — horizontal `ListView` |
| "Open this page when clicked on the caption" | `caption_block.dart` → `edit_caption_screen.dart` |
| "Open keyboard to edit the caption" | field autofocuses on push |
| "Enable Save button when a change is made" | `save_button.dart`, driven by a dirty flag |

---

## Assumptions and decisions

**Assets.** The Figma exports are not yet in the repo. Every image goes through
`AppImage` (`shared/widgets/app_image.dart`), which falls back to a drawn
gradient placeholder when the asset is missing, so the app builds and demos with
an empty `assets/images/`. Drop the real exports in at the paths in
`core/constants/app_assets.dart` and they appear with no code change.

**Typography.** The design is set in Satoshi, which is licensed and not
redistributable. The font declaration is commented out in `pubspec.yaml` and
`AppTypography.fontFamily` is `null`, so the app falls back to the platform sans
and the layout is unaffected. Add the `.otf` files to `assets/fonts/Satoshi/`,
uncomment the block and set `fontFamily = 'Satoshi'` for exact fidelity.

**Share icons.** The strip renders pre-styled brand buttons from
`assets/icons/` (Instagram, Facebook, WhatsApp, WhatsApp Business, Telegram,
TikTok, Oriflame). Each button falls back to a coloured circle with a
representative Material icon if its image fails to load. The row is a horizontal,
scrollable `ListView`.

**Bottom navigation.** Five unlabelled icons — discover, search, home, messages,
profile — with the active destination tinted brand green, matching the "Ready
for dev" frame (the design carries no icon labels).

**Product block vs. price.** Later frames show a trending line where earlier
frames show a price. Rather than stack both, `ProductCard` shows the trending
line when the product is trending and the price otherwise, with the discount
pill appended in both cases.

**Caption expansion.** "see more" expands the caption in place rather than
navigating, so the user does not lose their position in the feed. Tapping the
caption body itself opens the editor, as annotated.

**Unspecified states added.** A discard-changes dialog when leaving the editor
dirty; a confirmation snackbar after saving; snackbars standing in for the
share, camera, assistant and music actions so every control in the design does
something visible during a demo.

**Generation flow.** Matches the prototype: a full-screen takeover under the
header/tabs with a soft peach/rose gradient blob and a centred, rotating status
line ("Picking the best content for you…" →). Lines advance every 1.2 s with a
0.7 s hold on the last before the feed is revealed — fast enough to not stall the
demo, slow enough to read. The blob drifts on a slow loop; reduce-motion skips
the whole sequence.

**Timings.** The design specifies only the 3-second product reveal; the
generation-line cadence above is chosen to read comfortably.

---

## Responsiveness and accessibility

- Sizes are scaled against the 375×812 design frame and clamped between 0.85×
  and 1.30× so the layout holds on small handsets and does not balloon on
  tablets.
- Above 600 pt the feed keeps a centred 480 pt column instead of stretching a
  portrait photo across the viewport.
- Text scaling is capped at 1.3× on the feed — the card is dense and unbounded
  scaling overflows it.
- The 3-second reveal and the generation overlay respect the OS reduce-motion
  setting.
- Interactive elements carry semantic labels; the share icons carry tooltips
  that disambiguate the repeated brands.

---

## Adding the Figma exports

1. Export the post photos, product shots and avatar as images.
2. Drop them into `assets/images/` at the filenames listed in
   `core/constants/app_assets.dart` (e.g. `post_1.jpg`, `product_lipstick.jpg`,
   `avatar.jpg`).
3. Hot restart — `AppImage` picks them up automatically; no code change.

For the Satoshi typeface, add the `.otf` files to `assets/fonts/Satoshi/`,
uncomment the `fonts:` block in `pubspec.yaml`, and set
`AppTypography.fontFamily = 'Satoshi'`.

The share-brand buttons live in `assets/icons/` (`instagram.png`,
`facebook.png`, `whatsapp.png`, `whatsapp_business.png`, `telegram.png`,
`image.png` for TikTok, `oriflame_share.png`); their paths are mapped in
`core/constants/app_assets.dart`.

---

## Not built

Real sharing, a music picker, product deep links, authentication, a network
layer, and dark mode — none are in the design or the brief.
# oriflame
# oriflame
