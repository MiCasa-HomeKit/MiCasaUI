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

@_cdecl("createPluginBuilder")
  public func createPluginBuilder() -> UnsafeMutableRawPointer {
    return Unmanaged.passRetained(MiCasaUIPluginBuilder()).toOpaque()
  }

public class MiCasaUIPluginBuilder: MiCasaPluginBuilder<MiCasaUI> {
  // MARK: - Initialization

  public override init() {
  }

  // MARK: - Plugin Properties
  /// The plugin id. The id must be unique and constant; it mustn't change.
  public override var pluginId: String {
    return "3458f00e-308e-4778-8e89-c01442fe8e1d"
  }

  /// The plugin name. The plugin name must be unique and is a technical name.
  public override var pluginName: String {
    return "micasa-ui"
  }

  /// The plugin version.
  public override var pluginVersion: String {
    return "0.0.1"
  }

  // MARK: - Initialization

  /**
    This method must return an instance of the plugin.
    - Parameter apiGateway: The API that can be used by the plugin.
    - Returns: An instance of the plugin
    */
  public override func build(apiGateway: ApiGateway, configuration: Data) throws -> MiCasaUI {
    return try MiCasaUI(apiGateway: apiGateway, configuration: configuration)!
  }
}