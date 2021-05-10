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
import HAP
import MiCasaPlugin
import MiCasaUI

let configuration = """
{
  "port": 51969
}
""".data(using: .utf8)

class MiCasaUITestApp: ApiGateway {

  static let shared: MiCasaUITestApp = { MiCasaUITestApp() }()

  // MARK: - Properties

  private var keepRunning = true
  private var pluginBuilder = MiCasaUIPluginBuilder()
  private var micasaUi: MiCasaUI!

  public var accessories: [Accessory]

  // MARK: - Initialization

  private init() {
    self.accessories = []
  }

  // MARK: - Public Methods

  public func run() throws {
    micasaUi = try pluginBuilder.build(apiGateway: self, configuration: configuration!)
    try micasaUi.start()

    let keepRunning = true

    signal(SIGINT) { _ in
      MiCasaUITestApp.shared.stop()
    }
    signal(SIGTERM) { _ in
      MiCasaUITestApp.shared.stop()
    }

    withExtendedLifetime([]) {
      while keepRunning {
        RunLoop.current.run(mode: .default, before: Date.distantFuture)
      }
    }
  }

  // MARK: - ApiGateway

  func restart() {

  }

  func stop() {
    DispatchQueue.main.async {
      self.keepRunning = false
    }
  }

  func info(plugin: MiCasaPlugin, message: String) {

  }

  func warning(plugin: MiCasaPlugin, message: String) {

  }

  func error(plugin: MiCasaPlugin, message: String) {

  }

  func critical(plugin: MiCasaPlugin, message: String) {

  }

  func debug(plugin: MiCasaPlugin, message: String) {

  }

  func trace(plugin: MiCasaPlugin, message: String) {

  }
}
