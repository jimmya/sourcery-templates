import SourceryRuntime

extension Annotated {
    var isAutoStubbable: Bool {
        annotations["AutoStubbable"] as? Int == 1
    }

    var isAutoMockable: Bool {
        annotations["AutoMockable"] as? Int == 1
    }

    var isAutoRegisterable: Bool {
        annotations["AutoRegisterable"] as? Int == 1
    }

    var registrationValue: String? {
        annotations["registrationValue"] as? String
    }

    var registrationValues: String? {
        annotations["registrationValues"] as? String
    }
}
