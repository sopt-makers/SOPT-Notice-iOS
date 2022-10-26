//
//  AuthPushAlarmUseCase.swift
//  Presentation
//
//  Created by devxsby on 2022/10/23.
//  Copyright © 2022 SOPT-iOS. All rights reserved.
//

import Combine

import Core

public protocol AuthPushAlarmUseCase {
    func updatePartList(indexWithStatus: (index: Int, selected: Bool))
    func postPartList()
    func postEmptyList()
    var selectedPartStatus: [Int: Bool] { get set }
}

public class DefaultAuthPushAlarmUseCase {
    
    private let repository: AuthPushAlarmRepositoryInterface
    private var cancelBag = CancelBag()
    
    public var selectedPartStatus: [Int: Bool] = [:]
    
    public init(repository: AuthPushAlarmRepositoryInterface) {
        self.repository = repository
    }
}

extension DefaultAuthPushAlarmUseCase: AuthPushAlarmUseCase {
    public func updatePartList(indexWithStatus: (index: Int, selected: Bool)) {
        self.selectedPartStatus[indexWithStatus.index] = indexWithStatus.selected
    }
    
    public func postPartList() {
        let partList = makePartListForRequest()
        if partList.isEmpty {
            self.postEmptyList()
        } else {
            self.repository.postPartList(list: partList)
        }
    }
    
    private func makePartListForRequest() -> [String] {
        return selectedPartStatus
            .filter { $0.value == true }
            .sorted { $0.key < $1.key }
            .compactMap { AuthPushAlarmModel.indexToPart[$0.key] }
    }
    
    public func postEmptyList() {
        self.repository.postEmptyList()
    }
}
