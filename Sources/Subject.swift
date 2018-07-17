//
//  Subject.swift
//

public protocol Subject : class {
    func attach(_ observer: Observer)
    func detach(_ observer: Observer)
    func notify(about event: SubjectEvent)
}
