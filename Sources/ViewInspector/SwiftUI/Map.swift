//
//  Map.swift
//  ViewInspectorTests
//
//  Created by Tyler Thompson on 5/25/21.
//

#if canImport(MapKit)
import MapKit
import SwiftUI

@available(iOS 13.0, macOS 10.15, tvOS 13.0, *)
public extension ViewType {
    struct Map: KnownViewType {
        public static let typePrefix: String = "Map"
        public static var namespacedPrefixes: [String] {
            return ["_MapKit_SwiftUI." + typePrefix]
        }
        public static func inspectionCall(typeName: String) -> String {
            return "map(\(ViewType.indexPlaceholder))"
        }
    }
}

// MARK: - Extraction from SingleViewContent parent

@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
public extension InspectableView where View: SingleViewContent {
    func map() throws -> InspectableView<ViewType.Map> {
        let call = ViewType.inspectionCall(
            base: ViewType.Map.inspectionCall(typeName: ""), index: nil)
        return try .init(try child(), parent: self, call: call)
    }
}

@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
public extension InspectableView where View: MultipleViewContent {
    func map(_ index: Int) throws -> InspectableView<ViewType.Map> {
        let call = ViewType.inspectionCall(
            base: ViewType.Map.inspectionCall(typeName: ""), index: index)
        return try .init(try child(at: index), parent: self, call: call, index: index)
    }
}

@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
public extension InspectableView where View == ViewType.Map {
    func coordinateRegion() throws -> Binding<MKCoordinateRegion> {
        return try Inspector.attribute(path: "provider|region|region",
                                       value: content.view,
                                       type: Binding<MKCoordinateRegion>.self)
    }

    func interactionModes() throws -> MapInteractionModes {
        return try Inspector.attribute(path: "provider|interactionModes",
                                       value: content.view,
                                       type: MapInteractionModes.self)
    }

    func showsUserLocation() throws -> Bool {
        return try Inspector.attribute(path: "provider|showsUserLocation",
                                       value: content.view,
                                       type: Bool.self)
    }

    func userTrackingMode() throws -> Binding<MapUserTrackingMode>? {
        return try Inspector.attribute(path: "provider|userTrackingMode",
                                       value: content.view,
                                       type: Binding<MapUserTrackingMode>?.self)
    }

    func mapRect() throws -> Binding<MKMapRect> {
        return try Inspector.attribute(path: "provider|region|rect",
                                       value: content.view,
                                       type: Binding<MKMapRect>.self)
    }
}
#endif
