import SourceryRuntime

extension Type {
    var initMethods: [Method] {
        methods.filter { ($0.isInitializer || $0.isFailableInitializer) && !$0.isConvenienceInitializer }
    }
}
