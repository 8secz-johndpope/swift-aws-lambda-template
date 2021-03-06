import AWSLambdaEvents
import AWSLambdaRuntime
import Backtrace
import HelloWorld

Backtrace.install()

private let handler: Lambda.CodableVoidClosure<Cloudwatch.ScheduledEvent> = {
    context, request, callback in
    do {
        let greetingHour = try hour()
        let greetingMessage = try greeting(atHour: greetingHour)
        context.logger.info("\(greetingMessage)")
        callback(.success(()))
    } catch {
        context.logger.error("AnError: \(error.localizedDescription)")
        callback(.failure(error))
    }
}

#if DEBUG
    try Lambda.withLocalServer {
        Lambda.run(handler)
    }
#else
    Lambda.run(handler)
#endif
