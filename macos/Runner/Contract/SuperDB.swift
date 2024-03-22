import Foundation
import OSLog
import SwiftData
import CloudKit

protocol SuperDB {
    func create() -> String
    func getRecord(id: CKRecord.ID) -> CKRecord?
}

extension SuperDB {
    func create() -> String {
        return "刚刚点击了Create"
    }
    
    func getRecord(id: CKRecord.ID) -> CKRecord? {
        // RecordType = CloudKit 数据库的表名
        return CKRecord(recordType: "Test", recordID: id).setTitle("test \(Int(arc4random_uniform(100)))")
    }
}

extension CKRecord {
    func setTitle(_ t: String) -> Self {
        self[.title] = t
        return self
    }
}

extension CKRecord.FieldKey {
    static let title = "title"
}
