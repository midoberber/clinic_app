# clinic_app

Social Media Platform .
## Generating Resources
`flutter pub get`

`flutter pub run flutter_launcher_icons:main`

 ## locatization
 ```flutter pub pub run intl_translation:extract_to_arb --output-dir=lib/l10n lib/locale/localization.dart```

 ```flutter pub pub run intl_translation:generate_from_arb --output-dir=lib/l10n --no-use-deferred-loading lib/l10n/intl_en.arb lib/l10n/intl_messages.arb lib/l10n/intl_ar.arb lib/locale/localization.dart``` 
