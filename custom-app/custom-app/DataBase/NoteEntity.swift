//
//  NoteEntity.swift
//  custom-app
//
//  Created by ISN98 on 2022/03/19.
//

import Foundation
import CoreData


class NoteEntity: Entity {
    
    var entityName = "Note"
    var attributes: Dictionary<String, Any>
    
    let title: String
    let pdfDocumentData: Data
    let updateDate: Date
    let id: UUID
    
    init(id: UUID, title: String, pdfDocumentData: Data) {
        self.title = title
        self.pdfDocumentData = pdfDocumentData
        updateDate = Date()
        self.id = id
        self.attributes = [
            "id": id,
            "title": title,
            "pdfDocument": pdfDocumentData,
            "updateDate": updateDate,
        ]
    }
    
    init(id: UUID, title: String, pdfDocumentData: Data, updateDate: Date) {
        self.title = title
        self.pdfDocumentData = pdfDocumentData
        self.updateDate = updateDate
        self.id = id
        self.attributes = [
            "id": id,
            "title": title,
            "pdfDocument": pdfDocumentData,
            "updateDate": updateDate,
        ]
    }
    
    
    /**
     すべてのNoteEntityを取得
     */
    static func fetchAll() -> [Entity]{
        let allNotes = DatabaseController().fetch("Note", with: nil) as! [Note]
        
        var noteEntitys:[NoteEntity] = []
        allNotes.forEach({ note in
            noteEntitys.append(convertToEntity(from: note))
        })
        
        return  noteEntitys
    }
    
    /**
     作成
     */
    func insert(){
        print(id)
        print(title)
        print(updateDate)
        print(pdfDocumentData)
        DatabaseController().insert(entity: self)
    }
    
    
    /**
     idで取得
     */
    func fetchById(_ id: UUID) -> Entity {
        let notes = DatabaseController().fetch(entityName, with: "id = \(id)") as! [Note]
        guard notes.count == 1 else {
            fatalError()
        }
        return Self.convertToEntity(from: notes[0])
    }
    
    
    /**
     NoteオブジェクトをNoteEntityへ変換する
     */
    static func convertToEntity(from entity: Note) -> NoteEntity {
        return NoteEntity(id: entity.id!, title: entity.title!, pdfDocumentData: entity.pdfDocument!, updateDate: entity.updateDate!)
    }

}
