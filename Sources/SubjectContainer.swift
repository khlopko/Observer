//
//  SubjectContainer.swift
//

public typealias SubjectStrategy = Subject

public protocol SubjectContainer : Subject {
    var subjectStrategy: SubjectStrategy { get }
}

extension SubjectContainer {
    public func attach(_ observer: Observer) {
        subjectStrategy.attach(observer)
    }

    public func detach(_ observer: Observer) {
        subjectStrategy.detach(observer)
    }

    public func notify(about event: SubjectEvent) {
        subjectStrategy.notify(about: event)
    }
}
