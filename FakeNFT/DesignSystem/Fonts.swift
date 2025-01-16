import UIKit

extension UIFont {
    
    enum Regular {
        static var small = UIFont.systemFont(ofSize: 13, weight: .regular)
        static var medium = UIFont.systemFont(ofSize: 15, weight: .regular)
        static var large = UIFont.systemFont(ofSize: 17, weight: .regular)
    }

    enum Medium {
        static var small = UIFont.systemFont(ofSize: 10, weight: .medium)
    }

    enum Bold {
        static var small = UIFont.systemFont(ofSize: 17, weight: .bold)
        static var medium = UIFont.systemFont(ofSize: 22, weight: .bold)
        static var large = UIFont.systemFont(ofSize: 32, weight: .bold)
        static var extraLarge = UIFont.systemFont(ofSize: 34, weight: .bold)
    }
}
