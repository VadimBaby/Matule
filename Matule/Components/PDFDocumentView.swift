//
//  PDFDocumentView.swift
//  Matule
//
//  Created by Вадим Мартыненко on 11.05.2024.
//

import SwiftUI
import PDFKit

struct PDFDocumentView: UIViewRepresentable {
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
    func makeUIView(context: Context) -> some UIView {
        let pdfView = PDFView()
        
        if let url = Bundle.main.url(forResource: "document", withExtension: "pdf") {
            if let document = PDFDocument(url: url) {
                pdfView.document = document
            }
        }
        
        return pdfView
    }
}
