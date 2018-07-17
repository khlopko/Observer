import XCTest
@testable import Observer

final class ObserverTests : XCTestCase {
    
    func testNotify() {
        let subject = ASubject()
        let observer = AObserver()
        subject.attach(observer)
        subject.fireEvent()
        XCTAssert(observer.firedSubject is ASubject)
        XCTAssert(observer.processedEvent is Event)
    }

    func testRemoveNilObservers() {
        let subject = ASubject()
        var observer: Observer? = AObserver()
        subject.attach(observer!)
        observer = nil
        subject.fireEvent()
        let setBasedStrategy = subject.subjectStrategy as! SetBasedSubjectStrategy
        XCTAssertTrue(setBasedStrategy.observers.isEmpty)
    }

    func testSameInstanceReferenceSame() {
        let observer = AObserver()
        let ref1 = WeakReference<AObserver>(object: observer)
        let ref2 = WeakReference<AObserver>(object: observer)
        XCTAssertEqual(ref1, ref2)
    }

    func testDifferentInstanceOfOneTypeDifferent() {
        let observer1 = AObserver()
        let ref1 = WeakReference<AObserver>(object: observer1)
        let observer2 = AObserver()
        let ref2 = WeakReference<AObserver>(object: observer2)
        XCTAssertNotEqual(ref1, ref2)
    }

    static var allTests = [
        ("testNotify", testNotify),
    ]
}

private final class ASubject : SubjectContainer {
    private(set) lazy var subjectStrategy: SubjectStrategy = SetBasedSubjectStrategy(holderSubject: self)
    
    func fireEvent() {
        notify(about: Event())
    }
}

private final class AObserver : Observer {
    private(set) var processedEvent: SubjectEvent?
    private(set) weak var firedSubject: Subject?
    
    func update(in subject: Subject, event: SubjectEvent) {
        firedSubject = subject
        processedEvent = event
    }
}

private struct Event : SubjectEvent {
}
