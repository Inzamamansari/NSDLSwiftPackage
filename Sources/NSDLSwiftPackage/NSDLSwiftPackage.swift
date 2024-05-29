// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI
import Alamofire

#if canImport(UIKit)
@available(iOS 14.0, *)
public struct EmailListView: View {
    @State private var users: [User] = []
    @State private var selectedEmail: String?
    @Environment(\.presentationMode) var presentationMode
    let completion: (String) -> Void

    public init(completion: @escaping (String) -> Void) {
        self.completion = completion
    }

    public var body: some View {
        VStack {
            List(users, id: \.id) { user in
                Text(user.email)
            }
            Spacer()
            Button("Return To App") {
                returnFirstEmail()
            }
            .frame(width: 150, height: 50)
            .border(Color.black)
            .padding(.bottom, 10)
        }
        .onAppear(perform: callAPI)
    }

    private func callAPI() {
        let url = "https://reqres.in/api/users?page=1"
        AF.request(url).responseDecodable(of: UserResponse.self) { response in
            switch response.result {
            case .success(let userResponse):
                self.users = userResponse.data
#if DEBUG
                print(userResponse.data)
#endif
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    private func returnFirstEmail() {
        if let firstUser = users.first {
            completion(firstUser.email)
            presentationMode.wrappedValue.dismiss()
        }
    }
}

struct User: Decodable {
    let id: Int
    let email: String
}

struct UserResponse: Decodable {
    let data: [User]
}
#endif
