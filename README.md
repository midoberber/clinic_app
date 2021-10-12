# clinic_app

Social Media Platform .
## Generating Resources
`flutter pub get`

`flutter pub run flutter_launcher_icons:main`

 ## locatization
 ```flutter pub pub run intl_translation:extract_to_arb --output-dir=lib/l10n lib/locale/localization.dart```

 ```flutter pub pub run intl_translation:generate_from_arb --output-dir=lib/l10n --no-use-deferred-loading lib/l10n/intl_en.arb lib/l10n/intl_messages.arb lib/l10n/intl_ar.arb lib/locale/localization.dart``` 



# for faceboook 

generate development hash key : 
keytool -exportcert -alias androiddebugkey -keystore ~/.android/debug.keystore | openssl sha1 -binary | openssl base64


generate releas hash key : 
keytool -exportcert -alias clinic -keystore ~/key.jks | openssl sha1 -binary | openssl base64


# for firebase 
get sha1 , sha256 keys .. 


keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android -keypass android


# for releas key generation 

generate a release key store .. 
keytool -genkey -v -keystore ~/key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias clinic
pass : 123456


