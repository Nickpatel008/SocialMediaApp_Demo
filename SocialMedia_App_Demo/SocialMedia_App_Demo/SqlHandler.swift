//
//  SqlHandler.swift
//  SocialMedia_App_Demo
//
//  Created by Nick patel on 29/08/21.
//  Copyright © 2021 Nick patel. All rights reserved.
//

import Foundation
import SQLite3

class SqlHandler {
    
    static let sh = SqlHandler()
    
    let dbpath = "facepath.sqlite"
    var db:OpaquePointer?
    
    private init()
    {
        db = OpenDataBase()
        CreateTable_Post()
    }
    
    func OpenDataBase() -> OpaquePointer?
    {
        let docurl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let filepath = docurl.appendingPathComponent(dbpath)
        
        var database:OpaquePointer? = nil
        
        if sqlite3_open(filepath.path, &database) == SQLITE_OK {
            
            print("Database Connection Successfull...")
            print(filepath)
            return database
            
        }
        else
        {
            print("Database Connection Error...")
            return nil
        }
        
    }
    
    func CreateTable_Post(){
           let String_Student = """
               CREATE TABLE IF NOT EXISTS TBLPOST(
               ID INTEGER PRIMARY KEY AUTOINCREMENT,
               NAME TEXT,
               DETAIL TEXT,
               IMG DATA);
               """
           var createTableStatment:OpaquePointer? = nil
           if sqlite3_prepare(db, String_Student, -1, &createTableStatment, nil) == SQLITE_OK {
               if sqlite3_step(createTableStatment) == SQLITE_DONE{
                   print("Student NOTICE Table Created Successfuly..")
                
               }else{
                   print("Student NOTICE Table Could Not be Created ...")
               }
           }else{
               print("Create NOTICE Table Statment Could not Be Prepared...")
           }
           sqlite3_finalize(createTableStatment)
       }
    
    func Insert_Post(not:USERPOST)->Int{
        let Insert_Stud = """
        INSERT INTO TBLPOST
        (NAME,DETAIL,IMG)
        VALUES (?,?,?);
        """
        
        var insertTableStatment:OpaquePointer? = nil
        if sqlite3_prepare(db, Insert_Stud, -1, &insertTableStatment, nil) == SQLITE_OK {
            sqlite3_bind_text(insertTableStatment, 1, (not.name as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertTableStatment, 2, (not.detail as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertTableStatment, 3, (not.img as NSString).utf8String, -1, nil)
            if sqlite3_step(insertTableStatment) == SQLITE_DONE{
                print("Student Data Add Successfuly..")
                return 0
            }else{
                print("Student Data Add not Insert ...")
                return 1
                
            }
            
        }else{
            print("Insert Table Statment Could not Be Prepared...")
            return 1
        }
        
    }
    
    func Select_Notice()->[USERPOST]{
        let Update_Stud = "SELECT * FROM TBLPOST ;"
         var not = [USERPOST]()
        //var stud :[Student] = []
        var selectTableStatment1:OpaquePointer? = nil
        if sqlite3_prepare(db, Update_Stud, -1, &selectTableStatment1, nil) == SQLITE_OK {
            
            
            while sqlite3_step(selectTableStatment1) == SQLITE_ROW {
                let id = Int(sqlite3_column_int(selectTableStatment1, 0))
                let name = String(describing: String(cString: sqlite3_column_text(selectTableStatment1, 1)))
                let detail = String(describing: String(cString: sqlite3_column_text(selectTableStatment1, 2)))
                let img = String(describing: String(cString: sqlite3_column_text(selectTableStatment1, 3)))
                
                not.append(USERPOST(id: id, name: name, detail: detail, img: img))
                
                print("Student Data  Select Successfuly..")
            }
        }else{
            print("Select Table Statment Could not Be Prepared...")
        }
        sqlite3_finalize(selectTableStatment1)
        return not
    }
    
    
}
