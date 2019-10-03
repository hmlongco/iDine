//
//  MessageService.swift
//  iDine
//
//  Created by Michael Long on 9/27/19.
//  Copyright © 2019 Michael Long. All rights reserved.
//

import SwiftUI
import Combine

class MessageService: ObservableObject {

    enum Style {
        case custom(Styles)
        struct Styles {
            let foregroundColor: Color
            let backgroundColor: Color
            let font: Font
        }
    }

    @Published var message: String = ""

    fileprivate var styles = Style.Styles(foregroundColor: .white, backgroundColor: .blue, font: .callout)

    var autoHideInterval: TimeInterval? = 5.0

    private var cancellable: AnyCancellable?

    func show(message: String?, style: Style = .default) {
        guard let message = message, case let .custom(styles) = style else {
            hide()
            return
        }
        if message.isEmpty {
            DispatchQueue.main.async { [weak self] in
                self?.styles = styles
                self?.message = message
                self?.startTimer()
            }
        } else {
            hide()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [weak self] in
                self?.styles = styles
                self?.message = message
                self?.startTimer()
            }
        }
    }

    func hide() {
        cancellable?.cancel()
        DispatchQueue.main.async { [weak self] in
            self?.message = ""
        }
    }

    private func startTimer() {
        guard let interval = self.autoHideInterval else { return }
        self.cancellable = Timer.publish(every: interval, on: .main, in: .default)
            .autoconnect()
            .sink(receiveValue: { _ in
                self.hide()
            })
    }

}

extension MessageService.Style {

    static var `default`: MessageService.Style = Self.information

    static var information: MessageService.Style = {
        .custom(Styles(foregroundColor: .white, backgroundColor: .blue, font: .callout))
    }()

    static var error: MessageService.Style = {
        .custom(Styles(foregroundColor: .white, backgroundColor: .red, font: .callout))
    }()

}

extension MessageService {

    func show(error: String?) {
        show(message: error, style: .error)
    }

}

struct MessageOverlayView: View {

    @EnvironmentObject var messages: MessageService

    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                Text(messages.message)
                    .foregroundColor(messages.styles.foregroundColor)
                    .padding()
                Spacer()
                }
            }
            .font(messages.styles.font)
            .background(messages.styles.backgroundColor)
            .cornerRadius(15)
            .frame(width: UIScreen.main.bounds.width - 20)
            .offset(x: 0, y: messages.message.isEmpty ? -100 : 10)
            .animation(.interpolatingSpring(mass: 1.0, stiffness: 150, damping: 30, initialVelocity: 20))
            .onTapGesture {
                self.messages.hide()
            }
    }

}
