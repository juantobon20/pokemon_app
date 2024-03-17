//
//  Generated file. Do not edit.
//

import FlutterMacOS
import Foundation

import cryptography_flutter
import flutter_secure_storage_macos
import isar_flutter_libs
import package_info
import path_provider_foundation
import shared_preferences_foundation

func RegisterGeneratedPlugins(registry: FlutterPluginRegistry) {
  CryptographyFlutterPlugin.register(with: registry.registrar(forPlugin: "CryptographyFlutterPlugin"))
  FlutterSecureStorageMacosPlugin.register(with: registry.registrar(forPlugin: "FlutterSecureStorageMacosPlugin"))
  IsarFlutterLibsPlugin.register(with: registry.registrar(forPlugin: "IsarFlutterLibsPlugin"))
  FLTPackageInfoPlugin.register(with: registry.registrar(forPlugin: "FLTPackageInfoPlugin"))
  PathProviderPlugin.register(with: registry.registrar(forPlugin: "PathProviderPlugin"))
  SharedPreferencesPlugin.register(with: registry.registrar(forPlugin: "SharedPreferencesPlugin"))
}
