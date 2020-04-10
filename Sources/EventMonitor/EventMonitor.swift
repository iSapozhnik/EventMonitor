import Cocoa

public class EventMonitor {
    public enum MonitorType {
        case global
        case local
    }

    public typealias GlobalEventHandler = (NSEvent?) -> Void
    public typealias LocalEventHandler = (NSEvent?) -> NSEvent?

    private var monitor: Any?
    private let mask: NSEvent.EventTypeMask
    private let monitorType: MonitorType
    private let globalHandler: GlobalEventHandler?
    private let localHandler: LocalEventHandler?

    public init(monitorType: MonitorType, mask: NSEvent.EventTypeMask, globalHandler: GlobalEventHandler?, localHandler: LocalEventHandler?) {
        self.mask = mask
        self.monitorType = monitorType
        self.globalHandler = globalHandler
        self.localHandler = localHandler
    }

    deinit {
        stop()
    }

    public func start() {
        switch monitorType {
        case .global:
            startGlobalMonitor()
        case .local:
            startLocalMonitor()
        }
    }

    public func stop() {
        guard let monitor = self.monitor else { return }

        NSEvent.removeMonitor(monitor)
        self.monitor = nil
    }

    private func startGlobalMonitor() {
        guard let handler = globalHandler else {
            assertionFailure("Global event handler is not set.")
            return
        }
        monitor = NSEvent.addGlobalMonitorForEvents(matching: mask, handler: handler)
    }

    private func startLocalMonitor() {
        guard let handler = localHandler else {
            assertionFailure("Local event handler is not set.")
            return
        }
        monitor = NSEvent.addLocalMonitorForEvents(matching: mask, handler: handler)
    }
}
