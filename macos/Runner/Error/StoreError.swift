import SwiftUI

public enum StoreError: Error, LocalizedError {
    case failedVerification
    case canNotGetProducts
    
    public var errorDescription: String? {
        switch self {
        case .failedVerification:
            "failedVerification"
        case .canNotGetProducts:
            "发生错误：无法获取产品"
        }
    }
}
