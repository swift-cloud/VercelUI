//
//  Router+View.swift
//
//
//  Created by Andrew Barba on 1/23/23.
//

extension Router {

    public typealias ViewHandler<T: View> = (Request, Response) async throws -> T

    @discardableResult
    public func get<T: View>(
        _ path: String,
        cachePolicy: CachePolicy = .none,
        _ handler: @autoclosure @escaping () -> T
    ) -> Self {
        return get(path, cachePolicy: cachePolicy) { _, _ in handler() }
    }

    @discardableResult
    public func get<T: View>(
        _ path: String,
        cachePolicy: CachePolicy = .none,
        _ handler: @escaping ViewHandler<T>
    ) -> Self {
        return get(path, render(cachePolicy: cachePolicy, handler))
    }

    @discardableResult
    public func post<T: View>(
        _ path: String,
        cachePolicy: CachePolicy = .none,
        _ handler: @autoclosure @escaping () -> T
    ) -> Self {
        return post(path, cachePolicy: cachePolicy) { _, _ in handler() }
    }

    @discardableResult
    public func post<T: View>(
        _ path: String,
        cachePolicy: CachePolicy = .none,
        _ handler: @escaping ViewHandler<T>
    ) -> Self {
        return post(path, render(cachePolicy: cachePolicy, handler))
    }

    private func render<T: View>(
        cachePolicy: CachePolicy = .none,
        _ handler: @escaping ViewHandler<T>
    ) -> Router.Handler {
        return { req, res in
            RequestKey.defaultValue = req
            ResponseKey.defaultValue = res
            let view = try await handler(req, res)
                .environment(\.request, req)
                .environment(\.response, res)
            let html = StaticHTMLRenderer(view).render()
            return res
                .status(.ok)
                .cacheControl(maxAge: cachePolicy.maxAge, staleWhileRevalidate: cachePolicy.staleWhileRevalidate)
                .send(html: html)
        }
    }
}

// MARK: - Request Environment

private struct RequestKey: EnvironmentKey {
    static var defaultValue: Vercel.Request?
}

extension EnvironmentValues {
    public var request: Vercel.Request {
        get { self[RequestKey.self] ?? RequestKey.defaultValue! }
        set { self[RequestKey.self] = newValue }
    }
}

// MARK: - Response Environment

private struct ResponseKey: EnvironmentKey {
    static var defaultValue: Vercel.Response?
}

extension EnvironmentValues {
    public var response: Vercel.Response {
        get { self[ResponseKey.self] ?? ResponseKey.defaultValue! }
        set { self[ResponseKey.self] = newValue }
    }
}