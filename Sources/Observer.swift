
public protocol SubjectEvent {
}

public protocol Observer : class {
    func update(in subject: Subject, event: SubjectEvent)
}

public protocol Subject : class {
    func attach(_ observer: Observer)
    func detach(_ observer: Observer)
    func notify(about event: SubjectEvent)
}

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
