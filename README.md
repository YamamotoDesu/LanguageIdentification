# Text And Language Identification

## Language Identification
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

-----------

## Named Entity Recognition
```swift
private func printNamedEntities(text: String) {
    
    let tagger = NSLinguisticTagger(tagSchemes: [.nameType], options: 0)
    tagger.string = text
    
    let range = NSRange(location: 0, length: text.count)
    
    let options: NSLinguisticTagger.Options = [.omitPunctuation, .omitWhitespace, .joinNames]
    
    let tags: [NSLinguisticTag] = [.personalName, .placeName, .organizationName]
    
    tagger.enumerateTags(in: range, unit: .word, scheme: .nameType, options: options) { tag, tokenRange, stop in
        
        if let tag = tag, tags.contains(tag) {
            let name = (text as NSString).substring(with: tokenRange)
            print("\(name) is a \(tag.rawValue)")
        }
        
    }
    
}


["My name is John and I love to visit Australia", "My name is Mary and I work for Google","Yesterday, I went to Costa Rica and also met with James who works at Exxon", "Holla Comos Estas", "Yamamoto works at AMBL"].forEach { text in
        
    printNamedEntities(text: text)
    
}
```

### output
```
John is a PersonalName
Australia is a PlaceName
Mary is a PersonalName
Google is a OrganizationName
Costa Rica is a PlaceName
James is a PersonalName
Exxon is a OrganizationName
Yamamoto is a PersonalName
```
