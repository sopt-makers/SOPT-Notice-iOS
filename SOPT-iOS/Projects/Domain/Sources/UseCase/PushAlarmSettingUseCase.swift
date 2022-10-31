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
    func editPushSetting(toggleList: [Bool])
    var pushSetting: PassthroughSubject<PushAlarmSettingModel, Error> { get set }
    var editSettingStatusCode: PassthroughSubject<Int, Error> { get set }
}

public class DefaultPushAlarmSettingUseCase {
  
    private let repository: PushAlarmSettingRepositoryInterface
    private var cancelBag = CancelBag()
    public var pushSetting = PassthroughSubject<PushAlarmSettingModel, Error>()
    public var editSettingStatusCode = PassthroughSubject<Int, Error>()
  
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
    
    public func editPushSetting(toggleList: [Bool]) {
        let partList = toggleList.enumerated().filter {
            $0.1 == true
        }.map { (index, _) in
            PartCategory.allCases[index].rawValue
        }
        
        repository.editPushListSetting(partList: partList)
            .sink { event in
                print("completion: \(event)")
            } receiveValue: { value in
                self.editSettingStatusCode.send(value)
            }.store(in: cancelBag)
    }
}
