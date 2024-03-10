
import Foundation
// structure(struct) nu nam hammesha capital ma rakhavu
//struct K {
//    static let title = "⚡️FlashChat"
//    static let logInToChat = "LoginToChat"
//    static let registerToChat = "RegisterToChat"
//}

//aane vaparva mte K.title or K.logInToChat or K.registerToChat karvu static che etle

//jo static no hoy to pela object banavo pade let kk = K()

struct K {
    static let title = "⚡️FlashChat"
    static let cellIdentifier = "ReusableCell"
    static let cellNibName = "MessageCell"
    static let registerSegue = "RegisterToChat"
    static let loginSegue = "LoginToChat"
    
    struct BrandColors {
        static let purple = "BrandPurple"
        static let lightPurple = "BrandLightPurple"
        static let blue = "BrandBlue"
        static let lighBlue = "BrandLightBlue"
    }
    
    struct FStore {
        static let collectionName = "messages"
        static let senderField = "sender"
        static let bodyField = "body"
        static let dateField = "date"
    }
}



