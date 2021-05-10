/*
  Copyright 2020 MiCasa Development Team

  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at

  http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
*/

import Foundation
import MiCasaPlugin
import Swifter

struct MiCasaUIConfiguration: Codable {
  var port: UInt
}


public class MiCasaUI: MiCasaPlugin {

  // MARK: - Private Properties

  private var instanceId = UUID()
  private var config: MiCasaUIConfiguration!
  private var server: HttpServer!

  // MARK: - Initialization

  public override init?(apiGateway gateway: ApiGateway, configuration: Data) throws {
    try super.init(apiGateway: gateway, configuration: configuration)
    config = try self.configuration(configuration)
    server = HttpServer()
    try exposeUi()
  }

    // MARK: - Hashable

  public static func == (lhs: MiCasaUI, rhs: MiCasaUI) -> Bool {
    return lhs.instanceId == rhs.instanceId
  }

  open override func hash(into hasher: inout Hasher) {
    hasher.combine(instanceId)
  }

  // MARK: - API

  /// This method starts the plugin.
  open override func start() throws {
    try server.start(in_port_t(config.port), forceIPv4: true, priority: .background)
  }

  /// This method stops the plugin.
  ///
  /// The method is called before the bridge stops or is about to restart.
  open override func stop() throws {
    server.stop()
  }

  // MARK: - Private Methods

  private func exposeUi() throws {
    let uiPath =
     Bundle
       .module
       .resourceURL!
       .appendingPathComponent("Resources")
       .appendingPathComponent("MiCasaUI")

    try scanPath(uiPath.path, basePath: uiPath.path)
    server["/"] = { _ in .movedPermanently("/index.html")}
  }

  private func scanPath(_ path: String, basePath: String) throws {
    let directoryContents =
      try FileManager.default.contentsOfDirectory(
        at: URL(fileURLWithPath: path),
        includingPropertiesForKeys: nil,
        options: .skipsHiddenFiles)

    try directoryContents
      .forEach { fileUrl in
        if try isDirectory(fileUrl) {
          try scanPath(fileUrl.path, basePath: basePath)
        } else {
          let servingPath = fileUrl.absoluteURL.path.replacingOccurrences(of: basePath, with: "")

          server[servingPath] = shareFile(fileUrl.absoluteURL.path)
        }
      }
  }

  private func isDirectory(_ url: URL) throws -> Bool {
    return (try url.resourceValues(forKeys: [.isDirectoryKey])).isDirectory!
  }
}
