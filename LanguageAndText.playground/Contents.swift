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




//["Hello World","こんにちは", "Holla Comos Estas","5%%5","ہیلو آپ کیسے ہیں؟","Hello Holla"].forEach {
//    if let prediction = predictLanguage(text: $0) {
//        print(prediction)
//    }
//}

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

