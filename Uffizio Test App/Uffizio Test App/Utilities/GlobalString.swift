
import Foundation

// MARK: - Global Class to get strings in the project
class GlobalString : NSObject {
    
    func error() -> String {
        return String("Error")
    }
    func errorDescription() -> String {
        return String("Min value should not be greater than max value. Please do change and process")
    }
    func ok() -> String {
        return String("OK")
    }
    func cellID() -> String {
        return String("cell1")
    }
    func minimumValue(value: String) -> String {
        return String("Min \(value)")
    }
    func maximumValue(value: String) -> String {
        return String("Max \(value)")
    }
}
