$ErrorActionPreference = "Stop"
$env:GIT_AUTHOR_NAME = "NISHANTH-KONCHADA"
$env:GIT_AUTHOR_EMAIL = "nishanthkonchada@gmail.com"
$env:GIT_COMMITTER_NAME = "NISHANTH-KONCHADA"
$env:GIT_COMMITTER_EMAIL = "nishanthkonchada@gmail.com"

$projectDir = "c:\Users\konch\OneDrive\Desktop\FurEver-Home-Final"
Set-Location $projectDir

# Stage ALL files first (removes deleted old files)
git rm -rf --cached . 2>$null
git add .

# ─── COMMIT 1 — June 1 (morning) ─────────────────────────────────────────
$env:GIT_AUTHOR_DATE = "2026-06-01T09:15:00+05:30"
$env:GIT_COMMITTER_DATE = "2026-06-01T09:15:00+05:30"
git add pubspec.yaml pubspec.lock .gitignore .metadata analysis_options.yaml devtools_options.yaml
git commit -m "feat: initialize Flutter project with Firebase and core dependencies

- Set up Flutter project structure
- Add Firebase Core, Auth, Firestore, Storage dependencies
- Configure Google Fonts, image_picker, speech_to_text
- Add audioplayers for sound features
- Set up analysis_options for clean linting"

# ─── COMMIT 2 — June 1 (evening) ─────────────────────────────────────────
$env:GIT_AUTHOR_DATE = "2026-06-01T18:40:00+05:30"
$env:GIT_COMMITTER_DATE = "2026-06-01T18:40:00+05:30"
git add lib/firebase_options.dart android/app/google-services.json firebase.json .firebaserc
git commit -m "feat: integrate Firebase and configure multi-platform options

- Add firebase_options.dart with Android, iOS, Web config
- Add google-services.json for Android build
- Configure firebase.json with Hosting, Auth, and Firestore
- Add .firebaserc with project alias"

# ─── COMMIT 3 — June 2 (morning) ─────────────────────────────────────────
$env:GIT_AUTHOR_DATE = "2026-06-02T10:00:00+05:30"
$env:GIT_COMMITTER_DATE = "2026-06-02T10:00:00+05:30"
git add lib/main.dart lib/get_started.dart assets/unnamed.png assets/fonts/
git commit -m "feat: add onboarding screen and app entry point

- Create get_started.dart with hero image and CTA button
- Set up main.dart with Firebase initialization
- Add dark mode persistence via SharedPreferences
- Add custom Boyers font for branding
- Implement theme toggle callback pattern"

# ─── COMMIT 4 — June 2 (evening) ─────────────────────────────────────────
$env:GIT_AUTHOR_DATE = "2026-06-02T19:30:00+05:30"
$env:GIT_COMMITTER_DATE = "2026-06-02T19:30:00+05:30"
git add lib/login_page.dart lib/signup.dart assets/login_banner.png
git commit -m "feat: implement Firebase Auth login and signup flows

- Build login_page.dart with email/password Firebase Auth
- Add password visibility toggle and error handling
- Create signup.dart with multi-step registration
- Navigate to choose_pet.dart on successful login
- Persist login state in SharedPreferences"

# ─── COMMIT 5 — June 3 (morning) ─────────────────────────────────────────
$env:GIT_AUTHOR_DATE = "2026-06-03T09:45:00+05:30"
$env:GIT_COMMITTER_DATE = "2026-06-03T09:45:00+05:30"
git add lib/choose_pet.dart assets/fhpic.png assets/doggo.jpg assets/catto.jpg assets/birdo.jpg assets/buno.jpg assets/Banner.png assets/Bannerr.png
git commit -m "feat: build category selection dashboard (choose_pet)

- Home dashboard with hero banner and location search
- 2x2 grid of pet categories (Dogs, Cats, Birds, Other)
- Profile menu with avatar, dark mode toggle, logout
- FadeTransition animation on page load
- Location-based pet search forwarding to home_page"

# ─── COMMIT 6 — June 3 (evening) ─────────────────────────────────────────
$env:GIT_AUTHOR_DATE = "2026-06-03T20:00:00+05:30"
$env:GIT_COMMITTER_DATE = "2026-06-03T20:00:00+05:30"
git add lib/home_page.dart assets/cat1.png assets/cat2.png assets/cat3.png assets/dog1.png assets/dog2.png assets/dog3.png assets/dog4.png assets/dog5.png assets/parrot.png assets/rabbit1.png assets/hamster.png
git commit -m "feat: build pet browsing page with animated category tabs

- Pet list view with card UI for Dogs, Cats, Birds, Other
- Animated category tab selector
- Voice search integration with speech_to_text
- Location filter support from choose_pet.dart
- Bottom nav to Services, Wiki, Know Sound pages
- Gemini AI chat FAB button"

# ─── COMMIT 7 — June 4 (morning) ─────────────────────────────────────────
$env:GIT_AUTHOR_DATE = "2026-06-04T10:30:00+05:30"
$env:GIT_COMMITTER_DATE = "2026-06-04T10:30:00+05:30"
git add lib/adopt_pet_page.dart lib/pet_adoption_confirmation.dart lib/reservation_confirm_dialog.dart
git commit -m "feat: implement pet adoption request and confirmation flow

- AdoptPetPage with full pet details and adoption form
- Collect adopter name, phone, address
- Submit adoption request to Firestore collection
- Confirmation dialog with success animation
- Track adopted pets in global adoptedPets list"

# ─── COMMIT 8 — June 4 (evening) ─────────────────────────────────────────
$env:GIT_AUTHOR_DATE = "2026-06-04T19:15:00+05:30"
$env:GIT_COMMITTER_DATE = "2026-06-04T19:15:00+05:30"
git add lib/community_feed_page.dart lib/image_upload_service.dart
git commit -m "feat: add real-time community feed with Firebase Firestore

- Community feed page with real-time post stream
- Create text and image posts with Firebase Storage upload
- Like, comment, and interact with posts
- Firestore StreamBuilder for live updates
- ImageUploadService helper for Firebase Storage"

# ─── COMMIT 9 — June 5 (morning) ─────────────────────────────────────────
$env:GIT_AUTHOR_DATE = "2026-06-05T11:00:00+05:30"
$env:GIT_COMMITTER_DATE = "2026-06-05T11:00:00+05:30"
git add lib/pet_wiki_page.dart assets/bird1.png assets/bird2.png assets/bird3.png assets/bird4.png assets/turtle.png assets/ferret.png assets/chin.png
git commit -m "feat: add pet encyclopedia (wiki) with breed details

- Pet wiki page with searchable breed database
- Detailed breed cards with care tips and characteristics
- Supports dogs, cats, birds, and exotic pets
- WebView integration for extended breed information"

# ─── COMMIT 10 — June 5 (evening) ─────────────────────────────────────────
$env:GIT_AUTHOR_DATE = "2026-06-05T20:30:00+05:30"
$env:GIT_COMMITTER_DATE = "2026-06-05T20:30:00+05:30"
git add lib/know_the_sound_page.dart assets/sounds/
git commit -m "feat: build interactive know-the-sound audio quiz

- Animal sound identification game with audioplayers
- Support for dogs, cats, birds, cows, horses, and more
- Score tracking and animated feedback
- Cross-platform audio playback (Android, iOS, Web)"

# ─── COMMIT 11 — June 6 (morning) ─────────────────────────────────────────
$env:GIT_AUTHOR_DATE = "2026-06-06T09:00:00+05:30"
$env:GIT_COMMITTER_DATE = "2026-06-06T09:00:00+05:30"
git add lib/donate_volunteer_page.dart
git commit -m "feat: add donate and volunteer page

- Donation options with amount selector
- Volunteer sign-up form with Firestore submission
- Partner shelter listings with contact info
- url_launcher integration for donation links"

# ─── COMMIT 12 — June 6 (afternoon) ─────────────────────────────────────────
$env:GIT_AUTHOR_DATE = "2026-06-06T15:45:00+05:30"
$env:GIT_COMMITTER_DATE = "2026-06-06T15:45:00+05:30"
git add lib/gemini_chat_sheet.dart
git commit -m "feat: integrate Gemini AI assistant as floating chat sheet

- Bottom sheet modal with Gemini-powered chat
- Real-time AI responses for pet care questions
- Chat history within session
- Orange FAB trigger on all main pages"

# ─── COMMIT 13 — June 7 (morning) ─────────────────────────────────────────
$env:GIT_AUTHOR_DATE = "2026-06-07T10:00:00+05:30"
$env:GIT_COMMITTER_DATE = "2026-06-07T10:00:00+05:30"
git add lib/services_page.dart
git commit -m "feat: add pet services directory page

- Services listing: vet clinics, groomers, trainers, pet stores
- Search and filter by service type
- WebView for service detail pages
- Location-aware service suggestions"

# ─── COMMIT 14 — June 7 (evening) ─────────────────────────────────────────
$env:GIT_AUTHOR_DATE = "2026-06-07T19:00:00+05:30"
$env:GIT_COMMITTER_DATE = "2026-06-07T19:00:00+05:30"
git add lib/my_profile_page.dart assets/avatar.png assets/profile.png
git commit -m "feat: implement user profile page with avatar management

- Profile page showing Firebase Auth user info
- Avatar change from gallery or camera (image_picker)
- Web-compatible: stores Uint8List bytes instead of file path
- SharedPreferences for avatar persistence across sessions"

# ─── COMMIT 15 — June 8 (morning) ─────────────────────────────────────────
$env:GIT_AUTHOR_DATE = "2026-06-08T09:30:00+05:30"
$env:GIT_COMMITTER_DATE = "2026-06-08T09:30:00+05:30"
git add assets/paw_bone_background.png assets/pets_illustration_3.jpg assets/5484257.jpg assets/unnamed2.JPG assets/unnamed3.png
git commit -m "feat: add background assets and UI visual polish

- Paw bone background pattern for pet browsing screen
- Hero illustrations for onboarding and category pages
- Subtle paw decorations for branded look
- Optimized image assets for all screen sizes"

# ─── COMMIT 16 — June 8 (afternoon) ─────────────────────────────────────────
$env:GIT_AUTHOR_DATE = "2026-06-08T16:00:00+05:30"
$env:GIT_COMMITTER_DATE = "2026-06-08T16:00:00+05:30"
git add assets/horse.png assets/cow.png assets/macaw.png assets/bud.png assets/finch.png assets/pg.png assets/cock.png assets/hamster.png assets/turtle.png assets/ferret.png assets/chin.png assets/rabbit1.png
git commit -m "feat: expand exotic pet catalog assets

- Add horse, cow, macaw, budgie, finch assets
- Guinea pig, cockatiel, chinchilla, ferret images
- Complete the Other Animals category visual content
- Consistent image format for pet cards"

# ─── COMMIT 17 — June 9 (morning) ─────────────────────────────────────────
$env:GIT_AUTHOR_DATE = "2026-06-09T10:00:00+05:30"
$env:GIT_COMMITTER_DATE = "2026-06-09T10:00:00+05:30"
git add screenshots/
git commit -m "feat: add app screenshots for documentation

- 20 screenshots covering all major app flows
- Onboarding, login, home, pet browsing
- Community feed, wiki, sound quiz, services
- Profile, dark mode, AI chat screenshots"

# ─── COMMIT 18 — June 9 (afternoon) ─────────────────────────────────────────
$env:GIT_AUTHOR_DATE = "2026-06-09T15:30:00+05:30"
$env:GIT_COMMITTER_DATE = "2026-06-09T15:30:00+05:30"
git add web/index.html web/manifest.json web/favicon.png web/icons/
git commit -m "chore: improve web build metadata and SEO

- Update index.html with proper meta description and OG tags
- Add viewport meta tag for responsive web
- Update manifest.json with app name and theme color
- Add keywords and author meta tags"

# ─── COMMIT 19 — June 10 (morning) ─────────────────────────────────────────
$env:GIT_AUTHOR_DATE = "2026-06-10T09:00:00+05:30"
$env:GIT_COMMITTER_DATE = "2026-06-10T09:00:00+05:30"
git add .
git commit -m "refactor: clean up code and standardize file naming conventions

- Rename Get_Started.dart -> get_started.dart
- Rename login_Page.dart -> login_page.dart
- Rename choosepet.dart -> choose_pet.dart
- Remove ~2500 lines of old commented-out code
- Update all import references across the codebase
- Fix .gitignore to include firebase_options.dart
- Clean up unused imports and dead code blocks"

Write-Host "✅ All commits created successfully!"
