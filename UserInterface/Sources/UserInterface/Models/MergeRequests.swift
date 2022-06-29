// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//

import Foundation
import Defaults

// MARK: - GitLabQuery
public struct GitLabQuery: Codable, DefaultsSerializable, Equatable {
    public let data: DataClass?
}

public extension GitLabQuery {
    var authoredMergeRequests: [MergeRequest] {
        return self.data?.currentUser?.authoredMergeRequests?.edges?.compactMap({ edge in
            return edge.node
        }) ?? []
    }

    var reviewRequestedMergeRequests: [MergeRequest] {
        return self.data?.currentUser?.reviewRequestedMergeRequests?.edges?.compactMap({ edge in
            return edge.node
        }) ?? []
    }
}

// MARK: - DataClass
public struct DataClass: Codable, DefaultsSerializable, Equatable {
    public let currentUser: CurrentUser?
}

// MARK: - CurrentUser
public struct CurrentUser: Codable, DefaultsSerializable, Equatable {
    public let name: String?
    public let authoredMergeRequests: AuthoredMergeRequests?
    public let reviewRequestedMergeRequests: ReviewRequestedMergeRequests?
}

// MARK: - MergeRequest
public struct MergeRequest: Codable, DefaultsSerializable, Equatable {
    public let id, title: String?
    public let state: MergeRequestState?
    public let draft: Bool?
    public let webURL: URL?
    public let mergeStatusEnum: MergeStatus?
    public let approvedBy: ApprovedMergeRequests?
    public let approved: Bool?
    public let approvalsLeft: Int?
    public let userDiscussionsCount: Int?
    public let headPipeline: HeadPipeline?
    public let reference: String?
    public let targetProject: TargetProject?

    enum CodingKeys: String, CodingKey {
        case state, id, title, draft
        case webURL = "webUrl"
        case reference, targetProject, approvedBy, mergeStatusEnum, approved, approvalsLeft, userDiscussionsCount, headPipeline
    }
}

extension BidirectionalCollection where Element == MergeRequest {
    /// Goes through all merge requests and returns the approvedBy authors
    /// - Returns: in the format of `["!4": [Author]]`
    public var approvedByDict: [String: [Author]] {
        var beforeDict: [String: [Author]] = [:]
        self.forEach({ mr in
            guard let id = mr.reference else { return }
            let approved = mr.approvedBy?.edges?.compactMap({ $0.node })
            beforeDict[id] = approved
        })
        return beforeDict
    }
}

public struct Author: Codable, DefaultsSerializable, Equatable {
    public let id, name, username: String?
    public let avatarUrl: URL?

    enum CodingKeys: String, CodingKey {
        case id, name, username
        case avatarUrl = "avatarUrl"
    }
}

// MARK: - ApprovedMergeRequestsEdge
public struct ApprovedMergeRequestsEdge: Codable, DefaultsSerializable, Equatable {
    public let node: Author?
}

// MARK: - ApprovedMergeRequests
public struct ApprovedMergeRequests: Codable, DefaultsSerializable, Equatable {
    public let edges: [ApprovedMergeRequestsEdge]?
}

// MARK: - AuthoredMergeRequestsEdge
public struct AuthoredMergeRequestsEdge: Codable, DefaultsSerializable, Equatable {
    public let node: MergeRequest?
}

// MARK: - AuthoredMergeRequests
public struct AuthoredMergeRequests: Codable, DefaultsSerializable, Equatable {
    public let edges: [AuthoredMergeRequestsEdge]?
}

// MARK: - ReviewRequestedMergeRequests
public struct ReviewRequestedMergeRequests: Codable, DefaultsSerializable, Equatable {
    public let edges: [ReviewRequestedMergeRequestsEdge]?
}

// MARK: - ReviewRequestedMergeRequestsEdge
public struct ReviewRequestedMergeRequestsEdge: Codable, DefaultsSerializable, Equatable {
    public let node: MergeRequest?
}

// MARK: - JobsEdge
public struct JobsEdge: Codable, DefaultsSerializable, Equatable {
    public let node: HeadPipeline?
}

// MARK: - Jobs
public struct Jobs: Codable, DefaultsSerializable, Equatable {
    public let edges: [JobsEdge]?
}

// MARK: - FluffyNode
public struct FluffyNode: Codable, DefaultsSerializable, Equatable {
    public let id: String?
    public let status: StageStatusType?
    public let name: String?
    public let jobs: Jobs?
}

// MARK: - StagesEdge
public struct StagesEdge: Codable, DefaultsSerializable, Equatable {
    public let node: FluffyNode?
}

// MARK: - Stages
public struct Stages: Codable, DefaultsSerializable, Equatable {
    public let edges: [StagesEdge]?
}

// MARK: - HeadPipeline
public struct HeadPipeline: Codable, DefaultsSerializable, Equatable {
    public let id: String?
    public let active: Bool?
    public let status: PipelineStatus?
    public let stages: Stages?
    public let name: String?
    public let mergeRequestEventType: MergeRequestEventType?
}

// MARK: - TargetProject
public struct TargetProject: Codable, DefaultsSerializable, Equatable {
    public let id, name, path: String?
    public let webURL: URL?
    public let group: Group?

    enum CodingKeys: String, CodingKey {
        case id, name, path
        case webURL = "webUrl"
        case group
    }
}

// MARK: - Group
public struct Group: Codable, DefaultsSerializable, Equatable {
    public let id, name, fullName, fullPath: String?
    public let webURL: URL?

    enum CodingKeys: String, CodingKey {
        case id, name, fullName, fullPath
        case webURL = "webUrl"
    }
}

// MARK: - PipelineStatus
public enum PipelineStatus: String, Codable, DefaultsSerializable, Equatable {
    /// Pipeline has been created.
    case created = "CREATED"
    /// A resource (for example, a runner) that the pipeline requires to run is unavailable.
    case waitingForResource = "WAITING_FOR_RESOURCE"
    /// Pipeline is preparing to run.
    case preparing = "PREPARING"
    /// Pipeline has not started running yet.
    case pending = "PENDING"
    /// Pipeline is running.
    case running = "RUNNING"
    /// At least one stage of the pipeline failed.
    case failed = "FAILED"
    /// Pipeline completed successfully.
    case success = "SUCCESS"
    /// Pipeline was canceled before completion.
    case canceled = "CANCELED"
    /// Pipeline was skipped.
    case skipped = "SKIPPED"
    /// Pipeline needs to be manually started.
    case manual = "MANUAL"
    /// Pipeline is scheduled to run.
    case scheduled = "SCHEDULED"
}

// MARK: - MergeStatus
public enum MergeStatus: String, Codable, DefaultsSerializable, Equatable {
    case cannotBeMerged = "CANNOT_BE_MERGED"
    case cannotBeMergedRecheck = "CANNOT_BE_MERGED_RECHECK"
    case canBeMerged = "CAN_BE_MERGED"
    case checking = "CHECKING"
    case unchecked = "UNCHECKED"
}

// MARK: - MergeRequestState
public enum MergeRequestState: String, Codable, DefaultsSerializable, Equatable {
    case merged = "merged"
    case opened = "opened"
    case closed = "closed"
    case locked = "locked"
    case all = "all"
}

// MARK: - MergeRequestEventType
public enum MergeRequestEventType: String, Codable, DefaultsSerializable, Equatable {
    /// Pipeline run on the changes from the source branch combined with the target branch.
    case mergedResult = "MERGED_RESULT"
    /// Pipeline run on the changes in the merge request source branch.
    case detached = "DETACHED"
    /// Pipeline ran as part of a merge train.
    case mergeTrain = "MERGE_TRAIN"
}

public enum StageStatusType: String, Codable, DefaultsSerializable, Equatable {
    /// Pipeline has been created.
    case created = "created"
    /// A resource (for example, a runner) that the pipeline requires to run is unavailable.
    case waitingForResource = "waiting_for_resource"
    /// Pipeline is preparing to run.
    case preparing = "preparing"
    /// Pipeline has not started running yet.
    case pending = "pending"
    /// Pipeline is running.
    case running = "running"
    /// At least one stage of the pipeline failed.
    case failed = "failed"
    /// Pipeline completed successfully.
    case success = "success"
    /// Pipeline was canceled before completion.
    case canceled = "canceled"
    /// Pipeline was skipped.
    case skipped = "skipped"
    /// Pipeline needs to be manually started.
    case manual = "manual"
    /// Pipeline is scheduled to run.
    case scheduled = "scheduled"

    public func toPipelineStatus() -> PipelineStatus? {
        PipelineStatus(rawValue: self.rawValue.uppercased())
    }
}