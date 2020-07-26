
import Foundation
import UIKit

// MARK: - Global class to make Object round
class RoundedCorner: NSObject {
    
    func UIViewInCircle(uiView: UIView) {
        uiView.layer.cornerRadius = uiView.frame.size.width/2
        uiView.clipsToBounds = true
    }
    func ButtonInCircle(button: UIButton) {
        button.layer.cornerRadius = button.frame.size.width/2
        button.clipsToBounds = true
    }
}

// MARK: - Global function to convert UIColor from hex code
extension UIColor {
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        let hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        var color: UInt64 = 0
        scanner.scanHexInt64(&color)
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        let red = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue = CGFloat(b) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
}
