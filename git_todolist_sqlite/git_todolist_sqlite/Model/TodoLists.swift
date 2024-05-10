//
//  TodoLists.swift
//  SQLiteSimpleTodoList
//
//  Created by 박정민 on 5/7/24.
//


struct TodoLists{
    
    var id: Int32
    var items: String
    var complete: Int32
    var rank: Int32
        
    init(id: Int32, items: String, complete: Int32, rank: Int32) {
        self.id = id
        self.items = items
        self.complete = complete
        self.rank = rank
    }
}
    


