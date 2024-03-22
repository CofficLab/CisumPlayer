import Foundation
import OSLog
import SwiftData

protocol SuperLog {
}

extension SuperLog {
    var author: String {
        String(describing: type(of: self))
    }
    
    var isMain: String {
        "\(Thread.isMainThread ? "[🔥]" : "")"
    }
    
    var thread: String {
        Thread.current.name ?? "-"
    }
    
    var className: String {
        Thread.current.className
    }
    
    var title: String {
        "\(isMain) \(author):"
    }
    
    func i(_ message: String) -> String {
        "\(isMain) \(author): \(message)"
    }
}
