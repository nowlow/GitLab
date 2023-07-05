// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//

import Foundation
import Defaults

// MARK: - GitLabQuery
public struct GitLabQuery: Codable, Defaults.Serializable, Equatable {
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
public struct DataClass: Codable, Defaults.Serializable, Equatable {
    public let currentUser: CurrentUser?
}

// MARK: - CurrentUser
public struct CurrentUser: Codable, Defaults.Serializable, Equatable {
    public let name: String?
    public let authoredMergeRequests: AuthoredMergeRequests?
    public let reviewRequestedMergeRequests: ReviewRequestedMergeRequests?
}

// MARK: - MergeRequest
public struct MergeRequest: Codable, Defaults.Serializable, Equatable {
    public let id, title: String?
    public let state: MergeRequestState?
    public let draft: Bool?
    public let webURL: URL?
    public let mergeStatusEnum: MergeStatus?
    public let approvedBy: ApprovedMergeRequests?
    public let approved: Bool?
    public let approvalsLeft: Int?
    public let userDiscussionsCount: Int?
    public let userNotesCount: Int?
    public let headPipeline: HeadPipeline?
    public let reference: String?
    public let targetProject: TargetProject?

    enum CodingKeys: String, CodingKey {
        case state, id, title, draft
        case webURL = "webUrl"
        case reference, targetProject, approvedBy, mergeStatusEnum, approved, approvalsLeft, userDiscussionsCount, userNotesCount, headPipeline
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

extension BidirectionalCollection where Element == CollectionDifference<Author>.Change {
    /// Return all elements of changed type `.insert`
    var insertedElements: [Author] {
        return self.compactMap({ insertion -> Author? in
            guard case let .insert(offset: _, element: element, associatedWith: _) = insertion else {
                return nil
            }
            return element
        })
    }

    /// Return all elements of changed type `.remove`
    var removedElements: [Author] {
        return self.compactMap({ insertion -> Author? in
            guard case let .remove(offset: _, element: element, associatedWith: _) = insertion else {
                return nil
            }
            return element
        })
    }
}

public struct Author: Codable, Defaults.Serializable, Equatable {
    public let id, name, username: String?
    public let avatarUrl: URL?

    enum CodingKeys: String, CodingKey {
        case id, name, username
        case avatarUrl = "avatarUrl"
    }
}

/// (same as Author above ^ but with int for id
public struct EventAuthor: Codable, Defaults.Serializable, Equatable {
    public let id: Int?
    public let name, username: String?
    public let avatarUrl: URL?

    enum CodingKeys: String, CodingKey {
        case id, name, username
        case avatarUrl = "avatarUrl"
    }
}

// MARK: - ApprovedMergeRequestsEdge
public struct ApprovedMergeRequestsEdge: Codable, Defaults.Serializable, Equatable {
    public let node: Author?
}

// MARK: - ApprovedMergeRequests
public struct ApprovedMergeRequests: Codable, Defaults.Serializable, Equatable {
    public let edges: [ApprovedMergeRequestsEdge]?
}

// MARK: - AuthoredMergeRequestsEdge
public struct AuthoredMergeRequestsEdge: Codable, Defaults.Serializable, Equatable {
    public let node: MergeRequest?
}

// MARK: - AuthoredMergeRequests
public struct AuthoredMergeRequests: Codable, Defaults.Serializable, Equatable {
    public let edges: [AuthoredMergeRequestsEdge]?
}

// MARK: - ReviewRequestedMergeRequests
public struct ReviewRequestedMergeRequests: Codable, Defaults.Serializable, Equatable {
    public let edges: [ReviewRequestedMergeRequestsEdge]?
}

// MARK: - ReviewRequestedMergeRequestsEdge
public struct ReviewRequestedMergeRequestsEdge: Codable, Defaults.Serializable, Equatable {
    public let node: MergeRequest?
}

// MARK: - JobsEdge
public struct JobsEdge: Codable, Defaults.Serializable, Equatable {
    public let node: HeadPipeline?
}


// MARK: - Jobs
public struct Jobs: Codable, Defaults.Serializable, Equatable {
    public let edges: [JobsEdge]?
}

extension Jobs {
    // static let preview = Jobs(edges: [
    //     JobsEdge(node: .previewTestFailed),
    //     JobsEdge(node: .previewTestRunning1)
    // ])
    static let previewBuildJobs = Jobs(edges: [
        JobsEdge(node: .previewBuildiOS),
        JobsEdge(node: .previewBuildMacOS)
    ])
    static let previewTestJobs = Jobs(edges: [
        JobsEdge(node: .previewTestFailed),
        JobsEdge(node: .previewTestRunning1),
        JobsEdge(node: .previewTestRunning2),
        JobsEdge(node: .previewTestPending1),
        JobsEdge(node: .previewTestPending2)
    ])
}

// MARK: - FluffyNode
public struct FluffyNode: Codable, Defaults.Serializable, Equatable {
    public let id: String?
    public let status: StageStatusType?
    public let name: String?
    public let jobs: Jobs?
}

extension FluffyNode {
    // static let preview = FluffyNode(
    //     id: "id-id-id",
    //     status: .running,
    //     name: "Test",
    //     jobs: .previewBuildJobs
    // )

    static let previewBuild = FluffyNode(
        id: "id-id-id",
        status: .running,
        name: "Build",
        jobs: .previewBuildJobs
    )

    static let previewTest = FluffyNode(
        id: "id-id-id",
        status: .running,
        name: "Test",
        jobs: .previewTestJobs
    )

    static let previewNoChildren = FluffyNode(
        id: "id-id-id",
        status: .success,
        name: "Build",
        jobs: nil
    )
}

// MARK: - StagesEdge
public struct StagesEdge: Codable, Defaults.Serializable, Equatable {
    public let node: FluffyNode?
}

// MARK: - Stages
public struct Stages: Codable, Defaults.Serializable, Equatable {
    public let edges: [StagesEdge]?
}

extension Stages {
    static let previewParent = Stages(edges: [StagesEdge(node: .previewTest)])
    static let previewChild = Stages(edges: [StagesEdge(node: .previewNoChildren)])
}

// MARK: - HeadPipeline
public struct HeadPipeline: Codable, Defaults.Serializable, Equatable {
    public let id: String?
    public let active: Bool?
    public let status: PipelineStatus?
    public let stages: Stages?
    public let name: String?
    public let detailedStatus: DetailedStatus?
    public let mergeRequestEventType: MergeRequestEventType?
}

extension HeadPipeline {
    // previewBuildiOS
    // previewBuildMacOS
    // previewTestFailed
    // previewTestRunning1
    // previewTestRunning2
    // previewTestPending1
    // previewTestPending2
    static let previewBuildiOS = HeadPipeline(
        id: "id-id-id",
        active: true,
        status: .running,
        stages: .previewChild,
        name: "build:ios-dev",
        detailedStatus: .preview,
        mergeRequestEventType: .mergeTrain
    )

    static let previewBuildMacOS = HeadPipeline(
        id: "id-id-id",
        active: false,
        status: .success,
        stages: .previewChild,
        name: "build:macos-dev",
        detailedStatus: .preview,
        mergeRequestEventType: .mergedResult
    )

    static let previewTestFailed = HeadPipeline(
        id: "id-id-id",
        active: false,
        status: .failed,
        stages: .previewChild,
        name: "test:macos-uitest",
        detailedStatus: .preview,
        mergeRequestEventType: .mergedResult
    )

    static let previewTestRunning1 = HeadPipeline(
        id: "id-id-id",
        active: false,
        status: .running,
        stages: .previewChild,
        name: "test:macos-uitest",
        detailedStatus: .preview,
        mergeRequestEventType: .mergedResult
    )

    static let previewTestRunning2 = HeadPipeline(
        id: "id-id-id",
        active: false,
        status: .running,
        stages: .previewChild,
        name: "test:macos-unit",
        detailedStatus: .preview,
        mergeRequestEventType: .mergedResult
    )

    static let previewTestPending1 = HeadPipeline(
        id: "id-id-id",
        active: false,
        status: .waitingForResource,
        stages: .previewChild,
        name: "test:ios-unit",
        detailedStatus: .preview,
        mergeRequestEventType: .mergedResult
    )

    static let previewTestPending2 = HeadPipeline(
        id: "id-id-id",
        active: false,
        status: .pending,
        stages: .previewChild,
        name: "test:ios-uitest",
        detailedStatus: .preview,
        mergeRequestEventType: .mergedResult
    )
}

// MARK: - DetailedStatus
public struct DetailedStatus: Codable, Defaults.Serializable, Equatable {
    public let id: String?
    public let detailsPath: String?
}

extension DetailedStatus {
    static let preview = DetailedStatus(id: "id-id-id", detailsPath: "/details?...")
}

// MARK: - TargetProject
public struct TargetProject: Codable, Defaults.Serializable, Equatable, Hashable, Identifiable {
    public let id: String
    public let name, path: String?
    public let webURL: URL?
    public let avatarUrl: URL?
    public let namespace: NameSpace
    public let repository: Repository?
    public let group: Group?
    public let fetchedAvatarData: Data?

    enum CodingKeys: String, CodingKey {
        case id, name, path
        case webURL = "webUrl"
        case avatarUrl = "avatarUrl"
        case namespace
        case repository
        case group
        case fetchedAvatarData
    }
}

// MARK: - NameSpace
public struct NameSpace: Codable, Defaults.Serializable, Equatable, Hashable, Identifiable {
    public let id: String
    public let fullPath: String
    public let fullName: String

    enum CodingKeys: String, CodingKey {
        case id, fullPath, fullName
    }
}

// MARK: - Repository
public struct Repository: Codable, Defaults.Serializable, Equatable, Hashable {
    /// Main Branch
    public let rootRef: String?

    enum CodingKeys: String, CodingKey {
        case rootRef = "rootRef"
    }
}

// MARK: - Group
public struct Group: Codable, Defaults.Serializable, Equatable, Hashable {
    public let id, name, fullName, fullPath: String?
    public let webURL: URL?

    enum CodingKeys: String, CodingKey {
        case id, name, fullName, fullPath
        case webURL = "webUrl"
    }
}

// MARK: - PipelineStatus
public enum PipelineStatus: String, Codable, Defaults.Serializable, Equatable {
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
public enum MergeStatus: String, Codable, Defaults.Serializable, Equatable {
    case cannotBeMerged = "CANNOT_BE_MERGED"
    case cannotBeMergedRecheck = "CANNOT_BE_MERGED_RECHECK"
    case canBeMerged = "CAN_BE_MERGED"
    case checking = "CHECKING"
    case unchecked = "UNCHECKED"
}

// MARK: - MergeRequestState
public enum MergeRequestState: String, Codable, Defaults.Serializable, Equatable {
    case merged = "merged"
    case opened = "opened"
    case closed = "closed"
    case locked = "locked"
    case all = "all"
}

// MARK: - MergeRequestEventType
public enum MergeRequestEventType: String, Codable, Defaults.Serializable, Equatable {
    /// Pipeline run on the changes from the source branch combined with the target branch.
    case mergedResult = "MERGED_RESULT"
    /// Pipeline run on the changes in the merge request source branch.
    case detached = "DETACHED"
    /// Pipeline ran as part of a merge train.
    case mergeTrain = "MERGE_TRAIN"
}

public enum StageStatusType: String, Codable, Defaults.Serializable, Equatable {
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

// MARK: - ProjectImageResponse
public struct ProjectImageResponse: Codable, Defaults.Serializable, Equatable, Hashable {
    let fileName, filePath: String?
    let size: Int?
    let encoding, contentSha256, ref, blobID: String?
    let commitID, lastCommitID: String?
    let executeFilemode: Bool?
    let content: String?

    enum CodingKeys: String, CodingKey {
        case fileName = "file_name"
        case filePath = "file_path"
        case size, encoding
        case contentSha256 = "content_sha256"
        case ref = "ref"
        case blobID = "blob_id"
        case commitID = "commit_id"
        case lastCommitID = "last_commit_id"
        case executeFilemode = "execute_filemode"
        case content = "content"
    }
}