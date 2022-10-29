//
//  PushAlarmSettingUseCase.swift
//  Domain
//
//  Created by devxsby on 2022/10/17.
//  Copyright © 2022 SOPT-iOS. All rights reserved.
//

import Combine

import Core

public protocol PushAlarmSettingUseCase {
    func fetchPushSetting()
    var pushSetting: PassthroughSubject<PushAlarmSettingModel, Error> { get set }
}

public class DefaultPushAlarmSettingUseCase {
  
    private let repository: PushAlarmSettingRepositoryInterface
    private var cancelBag = CancelBag()
    public var pushSetting = PassthroughSubject<PushAlarmSettingModel, Error>()
  
    public init(repository: PushAlarmSettingRepositoryInterface) {
        self.repository = repository
    }
}

extension DefaultPushAlarmSettingUseCase: PushAlarmSettingUseCase {
    public func fetchPushSetting() {
        repository.fetchPushListSetting()
            .sink(receiveCompletion: { event in
                print("completion: \(event)")
            }, receiveValue: { value in
                self.pushSetting.send(value)
            })
            .store(in: cancelBag)
    }
}
