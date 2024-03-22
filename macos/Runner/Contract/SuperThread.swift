import Foundation

protocol SuperThread {
    
}

extension SuperThread {
    var threadName: String {
        "\(Thread.isMainThread ? "[🔥]" : "")"
    }
}
