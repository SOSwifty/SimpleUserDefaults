import Foundation


/// Storable - This protocol is used as a contraint for the types of objects that can be stored
protocol Storable { }

extension String: Storable { }
extension Bool: Storable { }
extension Int: Storable { }
extension Float: Storable { }
extension Double: Storable { }
extension Date: Storable { }
extension URL: Storable { }
extension Array: Storable where Element: Storable { }
extension Set: Storable where Element: Storable { }
extension Dictionary: Storable where Key == String, Value: Storable { }
extension Storable where Self: RawRepresentable, Self.RawValue: Storable { }
extension Data: Storable { }
