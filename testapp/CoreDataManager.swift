//
//  CoreDataManager.swift
//  testapp
//
//  Created by Andrei Matei on 16.09.2021.
//
//
// Created by Andrei Matei on 11/05/2020.
// Copyright (c) 2020 Andreea Matei. All rights reserved.
// https://developer.apple.com/documentation/coredata/synchronizing_a_local_store_to_the_cloud
// https://williamboles.me/can-unit-testing-and-core-data-become-bffs/
//

import Foundation
import CoreData
import CloudKit

class CoreDataManager {

    lazy var persistentContainer: NSPersistentContainer! = {

        let container = NSPersistentCloudKitContainer(name: "CKCONTAINER")
        let defaultDescription = container.persistentStoreDescriptions.first

        guard let url = defaultDescription?.url?.deletingLastPathComponent() else {
            fatalError("###\(#function): Failed to determine sqlite directory.")
        }

        let localStoreLocation = url.appendingPathComponent("local.sqlite")
        let localStoreDescription = NSPersistentStoreDescription(url: localStoreLocation)
        localStoreDescription.configuration = "local"

        let cloudStoreDescription = NSPersistentStoreDescription(url: url.appendingPathComponent("private.sqlite"))
        cloudStoreDescription.configuration = "privateCkStoreName"
        var privateCloudKitContainerOptions = NSPersistentCloudKitContainerOptions(containerIdentifier: "CKIDENTIFIFER")
        privateCloudKitContainerOptions.databaseScope = .private
        cloudStoreDescription.cloudKitContainerOptions = privateCloudKitContainerOptions
       
        container.persistentStoreDescriptions = [localStoreDescription, cloudStoreDescription]

        container.loadPersistentStores(completionHandler: { (_, error) in
            guard let error = error as NSError? else { return }
            fatalError("###\(#function): Failed to load persistent stores:\(error)")
        })

        return container
    }()

    static let shared = CoreDataManager()
}
