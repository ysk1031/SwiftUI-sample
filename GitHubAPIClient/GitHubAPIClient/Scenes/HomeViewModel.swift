//
//  HomeViewModel.swift
//  GitHubAPIClient
//
//  Created by Yusuke Aono on 2020/11/29.
//

import UIKit
import Combine

final class HomeViewModel: ObservableObject {
    // MARK: Inputs
    enum Inputs {
        case onCommit(text: String)
        case tappedCardView(urlString: String)
    }
    
    // MARK: Outputs
    @Published private(set) var cardViewInputs: [CardView.Input] = []
    @Published var inputText: String = ""
    @Published var isShowError = false
    @Published var isLoading = false
    @Published var isShowSheet = false
    @Published var repositoryURL: String = ""
    
    private let apiService: APIServiceType
    private let onCommitSubject = PassthroughSubject<String, Never>()
//    private let responseSubject = PassthroughSubject<SearchRepositoryResponse, Never>()
    private let errorSubject = PassthroughSubject<APIServiceError, Never>()
    
    private var cancellables: [AnyCancellable] = []
    
    init(apiService: APIServiceType) {
        self.apiService = apiService
        bind()
    }
    
    func apply(inputs: Inputs) {
        switch inputs {
        case .onCommit(let inputText):
            onCommitSubject.send(inputText)
        case .tappedCardView(let urlString):
            repositoryURL = urlString
            isShowSheet = true
        }
    }
    
    private func bind() {
        let responseSubscriber = onCommitSubject
            .flatMap { [apiService] query -> AnyPublisher<SearchRepositoryResponse, APIServiceError> in
                apiService.request(with: SearchRepositoryRequest(query: query))
            }
            .catch { [weak self] error -> Empty<SearchRepositoryResponse, Never> in
                self?.errorSubject.send(error)
                return .init()
            }
            .map { $0.items }
            .sink { [weak self] repositories in
                guard let self = self else { return }
                self.cardViewInputs = self.convertInput(repositories: repositories)
                self.inputText = ""
                self.isLoading = false
            }

        let loadingStartSubscriber = onCommitSubject
            .map { _ in true }
            .assign(to: \.isLoading, on: self)
        
        cancellables += [
            responseSubscriber,
            loadingStartSubscriber
        ]
    }
    
    private func convertInput(repositories: [Repository]) -> [CardView.Input] {
        return repositories.compactMap { repo -> CardView.Input? in
            do {
                guard let url = URL(string: repo.owner.avatarUrl) else {
                    return nil
                }
                let data = try Data(contentsOf: url)
                guard let image = UIImage(data: data) else {
                    return nil
                }
                return CardView.Input(
                    iconImage: image,
                    title: repo.name,
                    language: repo.language,
                    star: repo.stargazersCount,
                    description: repo.description,
                    url: repo.htmlUrl
                )
            } catch {
                return nil
            }
        }
    }
}
