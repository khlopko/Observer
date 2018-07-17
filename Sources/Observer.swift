//
// Observer.swift
//

public protocol Observer : class {
    func update(in subject: Subject, event: SubjectEvent)
}
