import Foundation
import SwiftUI

enum SmartError: Error, LocalizedError {
    case OnlySyncBook
    case iCloudDisabled
    case IdeaNotFound
    case HttpStatusError(_ code: Int)
    case HttpNoResponse
    case HttpNoData
    case CanNotCreateBackupFolder
    case CanNotFindCloudDocuments
    case ReadJSONError
    case NoCKRecordID
    case NotPro
    case NoDB
    case NoContext(_ author: String)
    case CanNotFormatWebResponse(_ error: Error)
    case CanNotCreateContainer(_ error: Error)
    case TypeNotIdea
    case DeleteNotAvailable
    case FunctionNotAvailable
    
    var errorDescription: String? {
        switch self {
        case .IdeaNotFound:
            return "找不到节点"
        case .OnlySyncBook:
            return "非图书节点，不能同步"
        case .iCloudDisabled:
            return "iCloud 未开启"
        case .CanNotCreateBackupFolder:
            return "创建备份目录失败"
        case .CanNotFindCloudDocuments:
            return "无法定位 iCloud Documents 目录"
        case .HttpStatusError(let code):
            return "HTTP 状态码异常 -> \(code)"
        case .HttpNoResponse:
            return "HTTP 无响应"
        case .HttpNoData:
            return "HTTP 无数据"
        case .ReadJSONError:
            return "读取 JSON 数据出错"
        case .NoCKRecordID:
            return "当前无 CKRecord ID"
        case .NoDB:
            return "找不到数据库"
        case .NoContext(let author):
            return "缺少 Context->\(author)"
        case .CanNotFormatWebResponse(let error):
            return "格式化 Web 的返回出错：\(error.localizedDescription)"
        case .CanNotCreateContainer(let error):
            return "无法创建数据库：\(error.localizedDescription)"
        case .TypeNotIdea:
            return "格式错误，必须是 Idea"
        case .DeleteNotAvailable:
            return "暂不支持删除"
        case .FunctionNotAvailable:
            return "功能尚未实现"
        case .NotPro:
            return "请订阅专业版解除数量限制"
        }
    }
}
