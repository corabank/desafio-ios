import UIKit

 extension UIColor {
     static var principal: UIColor { UIColor(red: 1.0, green: 0.24, blue: 0.43, alpha: 1.0) }
     static var secondary: UIColor { UIColor(red: 0.1, green: 0.58, blue: 0.85, alpha: 1.0) }
     static var gray2: UIColor { UIColor(red: 0.42, green: 0.44, blue: 0.46, alpha: 1.0) }
     static var grayButton: UIColor { UIColor(hexString: "#C7CBCF") }
     static var gray4: UIColor { UIColor(red: 0.94, green: 0.96, blue: 0.97, alpha: 1.0) }
     static var gray5: UIColor { UIColor(red: 0.23, green: 0.23, blue: 0.23, alpha: 1.0) }
     static var grayHeader: UIColor { UIColor(hexString: "#F0F4F8") }
     
     convenience init(hexString: String) {
         let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
         var int = UInt64()
         Scanner(string: hex).scanHexInt64(&int)
         let a, r, g, b: UInt64
         switch hex.count {
         case 3: // RGB (12-bit)
             (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
         case 6: // RGB (24-bit)
             (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
         case 8: // ARGB (32-bit)
             (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
         default:
             (a, r, g, b) = (255, 0, 0, 0)
         }
         self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
     }
 }
