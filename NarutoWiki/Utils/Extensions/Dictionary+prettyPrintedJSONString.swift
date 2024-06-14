import Foundation

extension Dictionary {

    var prettyPrintedJSONString: String? {
        guard
            let data = try? JSONSerialization.data(withJSONObject: self, options: [.prettyPrinted])
        else { return nil }

        return data.prettyPrintedJSONString
    }
}
