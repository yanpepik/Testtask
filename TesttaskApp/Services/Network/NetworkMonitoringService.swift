import Foundation
import Network
import Combine

protocol NetworkMonitoringServiceProtocol: ObservableObject {
    var isConnected: Bool { get }
    func recheck()
}

final class NetworkMonitoringService: NetworkMonitoringServiceProtocol {
    //MARK: - Properties
    private var monitor: NWPathMonitor?

    @Published private(set) var isConnected: Bool = true
    //MARK: - Initialization
    init() {
        startMonitoring()
    }

    //MARK: - Methods
    func recheck() {
        monitor?.cancel()
        startMonitoring()
    }

    deinit {
        monitor?.cancel()
    }

    //MARK: - Private Methods
    private func startMonitoring() {
        monitor = NWPathMonitor()
        let queue = DispatchQueue(label: "NetworkMonitorQueue")
        monitor?.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.isConnected = (path.status == .satisfied)
            }
        }
        monitor?.start(queue: queue)
    }
}
