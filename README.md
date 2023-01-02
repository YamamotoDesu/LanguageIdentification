# LanguageIdentification

```swift
import UIKit
import NaturalLanguage
import CoreML



private func predictLanguage(text: String) -> String? {
    
    let locale = Locale(identifier: "en")
    let recognizer = NLLanguageRecognizer()
    
    recognizer.processString(text)
    
    guard let language = recognizer.dominantLanguage else {
        return "Unable to predict language"
    }
    
    print(language)
    
    return locale.localizedString(forLanguageCode: language.rawValue)
    
}




["Hello World","こんにちは", "Holla Comos Estas","5%%5","ہیلو آپ کیسے ہیں؟","Hello Holla"].forEach {
    if let prediction = predictLanguage(text: $0) {
        print(prediction)
    }
}

```

### output
```
NLLanguage(_rawValue: en)
English
NLLanguage(_rawValue: ja)
Japanese
NLLanguage(_rawValue: es)
Spanish
Unable to predict language
NLLanguage(_rawValue: ur)
Urdu
NLLanguage(_rawValue: hu)
Hungarian
```
