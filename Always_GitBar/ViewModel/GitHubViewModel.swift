// ViewModel/GitHubViewModel.swift

import Foundation
import Combine
import AppKit

public class GitHubViewModel: ObservableObject {
    public static let shared = GitHubViewModel()
    
    @Published public var profileName: String = "로그인 필요"
    @Published public var avatarUrl: String? = nil
    @Published public var isLoggedIn: Bool = false
    @Published public var repositories: [GitHubRepo] = []
    @Published public var contributions: [ContributionDay] = []
    @Published public var followersCount: Int = 0
    @Published public var followingCount: Int = 0
    @Published public var publicReposCount: Int = 0
    
    private init() {
        if let token = KeychainHelper.shared.read() {
            fetchGitHubProfile(
                token: token
            )
            // 자동 데이터 갱신
            fetchGitHubProfile(
                token: token
            )
        }
    }
    
    public func exchangeCodeForToken(
        code: String
    ) {
        let clientID = ConfigLoader.getValue(
            forKey: "GITHUB_CLIENT_ID"
        ) ?? ""
        let clientSecret = ConfigLoader.getValue(
            forKey: "GITHUB_CLIENT_SECRET"
        ) ?? ""
        
        let url = URL(
            string: "https://github.com/login/oauth/access_token"
        )!
        var request = URLRequest(
            url: url
        )
        request.httpMethod = "POST"
        request
            .setValue(
                "application/json",
                forHTTPHeaderField: "Accept"
            )
        request
            .setValue(
                "application/x-www-form-urlencoded",
                forHTTPHeaderField: "Content-Type"
            )
        
        let bodyString = "client_id=\(clientID)&client_secret=\(clientSecret)&code=\(code)"
        request.httpBody = bodyString
            .data(
                using: .utf8
            )
        
        URLSession.shared
            .dataTask(
                with: request
            ) {
                data,
                _,
                _ in
                guard let data = data,
                      let json = try? JSONSerialization.jsonObject(
                        with: data
                      ) as? [String: Any],
                      let token = json["access_token"] as? String else {
                    print(
                        "❌ 토큰 파싱 실패"
                    )
                    return
                }
                
                print(
                    "🔑 토큰 획득 성공: \(token)"
                )
                _ = KeychainHelper.shared
                    .save(
                        token
                    )
                
                DispatchQueue.main.async {
                    self.isLoggedIn = true
                    self.fetchGitHubProfile(
                        token: token
                    )
            }
        }.resume()
    }
    // 주기적 갱신
    private var timer: AnyCancellable?
    
    private func startAutoRefresh(
        token: String
    ) {
        // 5분(300초)마다 데이터 갱신
        timer = Timer
            .publish(
                every: 300,
                on: .main,
                in: .common
            )
            .autoconnect()
            .sink { [weak self] _ in
                self?.fetchGitHubProfile(
                    token: token
                )
            }
    }
    
    public func fetchGitHubProfile(
        token: String
    ) {
        let url = URL(
            string: "https://api.github.com/user"
        )!
        var request = URLRequest(
            url: url
        )
        request
            .setValue(
                "Bearer \(token)",
                forHTTPHeaderField: "Authorization"
            )
        
        URLSession.shared
            .dataTask(
                with: request
            ) {
                data,
                response,
                _ in
                if let httpResponse = response as? HTTPURLResponse,
                   httpResponse.statusCode == 401 {
                    self.signOut()
                    return
                }
                guard let data = data,
                      let json = try? JSONSerialization.jsonObject(
                        with: data
                      ) as? [String: Any] else {
                    return
                }
                
                DispatchQueue.main
                    .async {
                        self.profileName = json["login"] as? String ?? "알 수 없음"
                        self.avatarUrl = json["avatar_url"] as? String
                        self.followersCount = json["followers"] as? Int ?? 0
                        self.followingCount = json["following"] as? Int ?? 0
                        self.publicReposCount = json["public_repos"] as? Int ?? 0
                        self.generateDummyContributions()
                        self.isLoggedIn = true
                        self.fetchRepositories(
                            token: token
                        )
                    }
            }.resume()
    }
    
    public func generateDummyContributions() {
        var temp: [ContributionDay] = []
        for _ in 0..<(
            7 * 18
        ) {
            let randomLevel = Int.random(
                in: 0...4
            )
            temp
                .append(
                    ContributionDay(
                        count: randomLevel * 2,
                        level: randomLevel
                    )
                )
        }
        self.contributions = temp
    }
    
    public func fetchRepositories(
        token: String
    ) {
        let url = URL(
            string: "https://api.github.com/user/repos?sort=updated&per_page=30"
        )!
        var request = URLRequest(
            url: url
        )
        request
            .setValue(
                "Bearer \(token)",
                forHTTPHeaderField: "Authorization"
            )
        
        URLSession.shared
            .dataTask(
                with: request
            ) {
                data,
                _,
                _ in
                guard let data = data else {
                    return
                }
                if let repoList = try? JSONDecoder().decode(
                    [GitHubRepo].self,
                    from: data
                ) {
                    DispatchQueue.main
                        .async {
                            self.repositories = repoList
                        }
                }
            }.resume()
    }
    
    public func signIn() {
        // Config.plist에서 값 불러오기
        guard let clientID = ConfigLoader.getValue(
            forKey: "GITHUB_CLIENT_ID"
        ) else {
            print(
                "GITHUB_CLIENT_ID Loader 실패"
            )
            return
        }
        
        let urlString = "https://github.com/login/oauth/authorize?client_id=\(clientID)&scope=user,repo"
        
        
        if let url = URL(
            string: urlString
        ) {
            NSWorkspace.shared
                .open(
                    url
                )
        }
    }
    
    public func signOut() {
        _ = KeychainHelper.shared
            .delete()
        DispatchQueue.main
            .async {
            self.profileName = "로그인 필요"
            self.avatarUrl = nil
            self.isLoggedIn = false
            self.repositories = []
            self.contributions = []
        }
    }
}
