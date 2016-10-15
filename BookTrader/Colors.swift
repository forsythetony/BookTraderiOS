
import UIKit

typealias Color = UIColor

extension Color {
    
    convenience init(hex: String) {
        var rgbInt: UInt64 = 0
        let newHex = hex.replacingOccurrences(of: "#", with: "")
        let scanner = Scanner(string: newHex)
        scanner.scanHexInt64(&rgbInt)
        let r: CGFloat = CGFloat((rgbInt & 0xFF0000) >> 16)/255.0
        let g: CGFloat = CGFloat((rgbInt & 0x00FF00) >> 8)/255.0
        let b: CGFloat = CGFloat(rgbInt & 0x0000FF)/255.0
        self.init(red: r, green: g, blue: b, alpha: 1.0)
    }
    
    
    class var DefaultTextFieldFontColor : Color {
        get {
            return Color.gray
        }
    }

    
    
    //  MARK: Application Colors
    class var BookLightOrange : Color {
        get {
            let hex = "F38630"
            
            return Color.init(hex: hex)
        }
    }
    
    class var BookDarkOrange : Color {
        get {
            let hex = "FA6900"
            
            return Color.init(hex: hex)
        }
    }
    
    class var BookGreenGray : Color {
        get {
            let hex = "E0E4CC"
            
            return Color.init(hex: hex)
        }
    }
    
    class var BookLightBlue : Color {
        get {
            let hex = "A7DBDB"
            
            return Color.init(hex: hex)
        }
    }
    
    class var BookBlue : Color {
        get {
            let hex = "69D2E7"
            
            return Color.init(hex: hex)
        }
    }
}
