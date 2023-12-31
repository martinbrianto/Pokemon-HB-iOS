//
//  String+Extension.swift
//  Pokemon HB iOS
//
//  Created by Martin Brianto on 08/11/23.
//

import RxSwift

extension String {
    func toRxCodable<CodableResponse: Codable>() -> Observable<CodableResponse> {
        guard let responseData = data(using: .utf8) else {
            let error = NSError(domain: "conversion error",
                                code: -1,
                                userInfo: [NSLocalizedDescriptionKey: "Unable to convert using utf8"])
            return Observable.error(error)
        }
        
        do {
            let response: CodableResponse = try JSONDecoder().decode(CodableResponse.self, from: responseData)
            return Observable.just(response)
        }
        catch {
            return Observable.error(error)
        }
    }
}
