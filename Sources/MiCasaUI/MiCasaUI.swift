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

struct MiCasaUIConfiguration: Codable {
  var port: Int16
}


public class MiCasaUI: MiCasaPlugin {

  // MARK: - Private Properties

  private var instanceId = UUID()
  private var config: MiCasaUIConfiguration!

  // MARK: - Initialization

  public override init?(apiGateway gateway: ApiGateway, configuration: Data) throws {
    try super.init(apiGateway: gateway, configuration: configuration)
    config = try self.configuration(configuration)
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
    // Empty by design
  }

  /// This method stops the plugin.
  ///
  /// The method is called before the bridge stops or is about to restart.
  open override func stop() throws {
    // Empty by design
  }
}
