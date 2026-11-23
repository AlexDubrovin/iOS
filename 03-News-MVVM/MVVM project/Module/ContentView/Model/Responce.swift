import Foundation

nonisolated struct Responce: Decodable, Hashable{
    let articles: [News]
}

struct News: Decodable, Hashable{
    let title: String?
    let autor: String?
}
