// Application/AppDelegate.swift

import SwiftUI
import ServiceManagement

class AppDelegate: NSObject, NSApplicationDelegate {
    var statusItem: NSStatusItem?
    let popover = NSPopover()
    
    func applicationDidFinishLaunching(
        _ notification: Notification
    ) {
        // 앱을 시작 프로그램에 등록
        do {
            try SMAppService.mainApp
                .register()
        } catch {
            print(
                "자동 실행 실패"
            )
        }
        
        NSApp
            .setActivationPolicy(
                .accessory
            )
        try? SMAppService.mainApp
            .register()
        
        DispatchQueue.main
            .async {
                self.statusItem = NSStatusBar.system
                    .statusItem(
                        withLength: NSStatusItem.variableLength
                    )
                if let button = self.statusItem?.button {
                    if let customIcon = NSImage(
                        named: "AppStatusBarIcon"
                    ) {
                        customIcon.isTemplate = true // 상단바 다크모드 대응
                        button.image = customIcon
                    }
                    button.action = #selector(
                        self.togglePopover
                    )
                    button.target = self
                }
                
                self.popover.contentViewController = NSHostingController(
                    rootView: HomeView()
                )
                self.popover.behavior = .transient
            }
    }
    
    // URL 콜백 처리 로직
    func application(
        _ application: NSApplication,
        open urls: [URL]
    ) {
        guard let url = urls.first else {
            return
        }
        
        if let code = URLComponents(
            url: url,
            resolvingAgainstBaseURL: false
        )?.queryItems?.first(
            where: {
                $0.name == "code"
            })?.value {
            // GitHubViewModel 토큰 교환 요청
            GitHubViewModel.shared
                .exchangeCodeForToken(
                    code: code
                )
        }
    }
    
    @objc func togglePopover() {
        if popover.isShown {
            popover
                .performClose(
                    nil
                )
        } else if let button = statusItem?.button {
            popover
                .show(
                    relativeTo: button.bounds,
                    of: button,
                    preferredEdge: .minY
                )
            popover.contentViewController?.view.window?
                .makeKey()
        }
    }
    
    func applicationWillFinishLaunching(
        _ notification: Notification
    ) {
        // 이 부분이 시스템이 URL을 감지하도록 등록하는 핵심입니다.
        NSAppleEventManager
            .shared()
            .setEventHandler(
                self,
                andSelector: #selector(
                    handleURLEvent
                ),
                forEventClass: AEEventClass(
                    kInternetEventClass
                ),
                andEventID: AEEventID(
                    kAEGetURL
                )
            )
    }
    
    @objc func handleURLEvent(
        _ event: NSAppleEventDescriptor,
        withReplyEvent replyEvent: NSAppleEventDescriptor
    ) {
        // 여기서 로그가 찍히는지 확인하세요!
        let urlString = event.paramDescriptor(
            forKeyword: keyDirectObject
        )?.stringValue ?? "URL 없음"
        print(
            "🔍 앱이 받은 URL: \(urlString)"
        )
        
        if let url = URL(
            string: urlString
        ),
           let code = URLComponents(
            url: url,
            resolvingAgainstBaseURL: false
           )?.queryItems?.first(
            where: {
                $0.name == "code"
            })?.value {
            print(
                "✅ 코드 추출 성공: \(code)"
            )
            GitHubViewModel.shared
                .exchangeCodeForToken(
                    code: code
                )
        } else {
            print(
                "❌ 코드 추출 실패"
            )
            }
        }
    }
