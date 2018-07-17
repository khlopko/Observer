//
//  SetBasedSubjectStrategy.swift
//

public final class SetBasedSubjectStrategy : SubjectStrategy {

    internal private(set) var observers = Set<WeakReference<Observer>>()
    private unowned let holderSubject: Subject

    public init(holderSubject: Subject) {
        self.holderSubject = holderSubject
    }

    public final func attach(_ observer: Observer) {
        observers.insert(WeakReference(object: observer))
    }

    public final func detach(_ observer: Observer) {
        observers.remove(WeakReference(object: observer))
    }

    public func notify(about event: SubjectEvent) {
        for reference in observers {
            if let observer: Observer = reference.getRef() {
                observer.update(in: holderSubject, event: event)
            } else {
                observers.remove(reference)
            }
        }
    }
}

open class WeakReference<T> : Hashable {

    public let hashValue: Int
    private weak var object: AnyObject?

    public init(object: AnyObject) {
        self.object = object
        hashValue = ObjectIdentifier(object).hashValue
    }

    public func getRef() -> T? {
        return object as? T
    }
}

public func == <T> (lhs: WeakReference<T>, rhs: WeakReference<T>) -> Bool {
    return lhs.hashValue == rhs.hashValue
}
