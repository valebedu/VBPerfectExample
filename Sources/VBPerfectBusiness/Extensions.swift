//
//  Extensions.swift
//  VBPerfectExample
//
//  Created by Valentin Bercot on 05/03/2017.
//
//

import PerfectHTTP
import VBPerfectArchitecture

extension VBPerfectController
{
    func supportedMediaTypeAccept(request: HTTPRequest) -> Bool
    {
        return request.header(.accept) == nil || request.header(.accept) != nil && request.header(.accept)!.contains(string: "application/json")
    }
    
    func supportedMediaTypeAcceptCharset(request: HTTPRequest) -> Bool
    {
        return request.header(.acceptCharset) == nil || request.header(.acceptCharset) != nil && request.header(.acceptCharset)!.contains(string: "utf-8")
    }
    
    func supportedMediaTypeAcceptEncoding(request: HTTPRequest) -> Bool
    {
        return request.header(.acceptEncoding) == nil || request.header(.acceptEncoding) != nil && (request.header(.acceptEncoding)!.contains(string: "gzip") || request.header(.acceptEncoding)!.contains(string: "deflate"))
    }
    
    func supportedMediaTypeContentType(request: HTTPRequest) -> Bool
    {
        return request.header(.contentType) != nil && request.header(.contentType)!.contains(string: "application/json")
    }
}

extension VBPerfectInteractor
{
    func ok(response: HTTPResponse) -> Bool
    {
        var result = false
        switch response.status
        {
        case .ok, .accepted, .nonAuthoritativeInformation, .noContent, .resetContent, .partialContent:
            result = true
            break
        default:
            break
        }
        
        return result
    }
}

extension VBPerfectPresenter
{
    func ok(response: HTTPResponse) -> Bool
    {
        var result = false
        switch response.status
        {
        case .ok, .accepted, .nonAuthoritativeInformation, .noContent, .resetContent, .partialContent:
            result = true
            break
        default:
            break
        }
        
        return result
    }
}
