// View/Tab/HomeView.swift

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = GitHubViewModel.shared
    @State private var selectedTab = 0
    let rows = Array(
        repeating: GridItem(
            .fixed(
                8
            ),
            spacing: 3
        ),
        count: 7
    )
    
    var body: some View {
        VStack(
            spacing: 0
        ) {
            if viewModel.isLoggedIn {
                headerSection
                tabBarSection
                ZStack {
                    if selectedTab == 0 {
                        overviewSection
                    } else {
                        repositorySection
                    }
                }
            } else {
                loginView
            }
        }
        .padding(
            14
        )
        .frame(
            width: 310
        )
    }
    
    private var headerSection: some View {
        HStack(
            spacing: 12
        ) {
            if let avatarUrl = viewModel.avatarUrl, let url = URL(
                string: avatarUrl
            ) {
                AsyncImage(
                    url: url
                ) {
                    image in image.resizable().clipShape(
                        Circle()
                    )
                }
                placeholder: {
                    ProgressView().controlSize(
                        .small
                    )
                }
                .frame(
                    width: 38,
                    height: 38
                )
            }
            VStack(
                alignment: .leading,
                spacing: 1
            ) {
                Text(
                    viewModel.profileName
                )
                .font(
                    .system(
                        size: 14,
                        weight: .bold
                    )
                )
                Text(
                    "Active Contribution"
                )
                .font(
                    .system(
                        size: 10,
                        weight: .medium
                    )
                )
                .foregroundColor(
                    .green
                )
            }
            Spacer()
            Button(
                action: {
                    viewModel.signOut()
                }) {
                    Image(
                        systemName: "power"
                    )
                    .foregroundColor(
                        .red.opacity(
                            0.8
                        )
                    )
                    .padding(
                        6
                    )
                    .background(
                        Color.red.opacity(
                            0.1
                        )
                    )
                    .clipShape(
                        Circle()
                    )
                }.buttonStyle(
                    .plain
                )
        }.padding(
            .bottom,
            12
        )
    }
    
    private var tabBarSection: some View {
        HStack(
            spacing: 4
        ) {
            TabButton(
                title: "Overview 🌿",
                isSelected: selectedTab == 0
            ) {
                withAnimation {
                    selectedTab = 0
                }
            }
            TabButton(
                title: "Repositories 📦",
                isSelected: selectedTab == 1
            ) {
                withAnimation {
                    selectedTab = 1
                }
            }
        }
        .padding(
            3
        )
        .background(
            Color.black.opacity(
                0.08
            )
        )
        .cornerRadius(
            8
        )
        .padding(
            .bottom,
            14
        )
    }
    
    private var overviewSection: some View {
        VStack(
            spacing: 12
        ) {
            VStack(
                alignment: .leading,
                spacing: 6
            ) {
                Text(
                    "Contribution Graph"
                )
                .font(
                    .system(
                        size: 10,
                        weight: .bold
                    )
                )
                .foregroundColor(
                    GitTheme.textSub
                )
                ScrollView(
                    .horizontal,
                    showsIndicators: false
                ) {
                    LazyHGrid(
                        rows: rows,
                        spacing: 3
                    ) {
                        ForEach(
                            viewModel.contributions
                        ) { day in
                            RoundedRectangle(
                                cornerRadius: 1.5
                            )
                            .fill(
                                GitTheme.grassColor(
                                    for: day.level
                                )
                            )
                            .frame(
                                width: 8,
                                height: 8
                            )
                        }
                    }.padding(
                        6
                    )
                }.background(
                    GitTheme.cardBg
                ).cornerRadius(
                    8
                )
            }
            HStack(
                spacing: 10
            ) {
                InfoCard(
                    title: "Followers",
                    count: "\(viewModel.followersCount)",
                    icon: "person.2.fill",
                    iconColor: .blue
                )
                InfoCard(
                    title: "Following",
                    count: "\(viewModel.followingCount)",
                    icon: "arrow.right.circle.fill",
                    iconColor: .purple
                )
                InfoCard(
                    title: "Public Repos",
                    count: "\(viewModel.publicReposCount)",
                    icon: "tray.full.fill",
                    iconColor: .orange
                )
            }
        }
    }
    
    private var repositorySection: some View {
        ScrollView {
            VStack(
                spacing: 6
            ) {
                ForEach(
                    viewModel.repositories
                ) { repo in
                    Button(
                        action: {
                            if let url = URL(
                                string: repo.htmlUrl
                            ) {
                                NSWorkspace.shared
                                    .open(
                                        url
                                    )
                            }
                        }) {
                            HStack(
                                spacing: 10
                            ) {
                                Circle()
                                    .fill(
                                        repo.isPrivate ? .orange : .blue
                                    )
                                    .frame(
                                        width: 6,
                                        height: 6
                                    )
                                VStack(
                                    alignment: .leading,
                                    spacing: 2
                                ) {
                                    Text(
                                        repo.name
                                    )
                                    .font(
                                        .system(
                                            size: 12,
                                            weight: .semibold
                                        )
                                    )
                                    .foregroundColor(
                                        GitTheme.textMain
                                    )
                                    Text(
                                        repo.fullName
                                    )
                                    .font(
                                        .system(
                                            size: 9
                                        )
                                    )
                                    .foregroundColor(
                                        GitTheme.textSub
                                    )
                                }
                                Spacer()
                                Image(
                                    systemName: "chevron.right"
                                )
                                .font(
                                    .system(
                                        size: 10
                                    )
                                )
                                .foregroundColor(
                                    GitTheme.textSub.opacity(
                                        0.5
                                    )
                                )
                            }
                            .padding(
                                10
                            )
                            .background(
                                GitTheme.cardBg
                            )
                            .cornerRadius(
                                8
                            )
                        }
                        .buttonStyle(
                            .plain
                        ) // 기본 버튼 스타일 제거
                }
            }
        }
        .frame(
            maxHeight: 160
        )
    }
    
    private var loginView: some View {
        VStack(
            spacing: 16
        ) {
            Image(
                systemName: "terminal.fill"
            )
            .font(
                .system(
                    size: 26
                )
            )
            .foregroundColor(
                .green
            )
            Text(
                "GitBar"
            )
            .font(
                .system(
                    size: 16,
                    weight: .bold
                )
            )
            PrimaryButton(
                title: "GitHub 계정 연결하기"
            ) {
                viewModel.signIn()
            }
        }.frame(
            minHeight: 180
        )
    }
}
