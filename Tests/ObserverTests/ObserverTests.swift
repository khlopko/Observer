import XCTest
@testable import Observer

final class ObserverTests: XCTestCase {
    
    func testNotify() {
        let subject = ASubject()
        let observer = AObserver()
        subject.attach(observer)
        subject.fireEvent()
        XCTAssert(observer.firedSubject is ASubject)
        XCTAssert(observer.processedEvent is Event)
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
