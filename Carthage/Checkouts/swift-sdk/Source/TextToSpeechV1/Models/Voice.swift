/**
 * Copyright IBM Corporation 2018
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 **/

import Foundation

/** Voice. */
public struct Voice: Decodable {

    /// The URI of the voice.
    public var url: String

    /// The gender of the voice: `male` or `female`.
    public var gender: String

    /// The name of the voice. Use this as the voice identifier in all requests.
    public var name: String

    /// The language and region of the voice (for example, `en-US`).
    public var language: String

    /// A textual description of the voice.
    public var description: String

    /// If `true`, the voice can be customized; if `false`, the voice cannot be customized. (Same as `custom_pronunciation`; maintained for backward compatibility.).
    public var customizable: Bool

    /// Describes the additional service features supported with the voice.
    public var supportedFeatures: SupportedFeatures

    /// Returns information about a specified custom voice model. **Note:** This field is returned only when you list information about a specific voice and specify the GUID of a custom voice model that is based on that voice.
    public var customization: VoiceModel?

    // Map each property name to the key that shall be used for encoding/decoding.
    private enum CodingKeys: String, CodingKey {
        case url = "url"
        case gender = "gender"
        case name = "name"
        case language = "language"
        case description = "description"
        case customizable = "customizable"
        case supportedFeatures = "supported_features"
        case customization = "customization"
    }

}
