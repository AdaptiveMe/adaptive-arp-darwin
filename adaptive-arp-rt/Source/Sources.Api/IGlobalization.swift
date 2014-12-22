/**
--| ADAPTIVE RUNTIME PLATFORM |----------------------------------------------------------------------------------------

(C) Copyright 2013-2015 Carlos Lozano Diez t/a Adaptive.me <http://adaptive.me>.

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the
License. You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0 . Unless required by appli-
-cable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS,  WITHOUT
WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the  License  for the specific language governing
permissions and limitations under the License.

Original author:

    * Carlos Lozano Diez
            <http://github.com/carloslozano>
            <http://twitter.com/adaptivecoder>
            <mailto:carlos@adaptive.me>

Contributors:

    * Ferran Vila Conesa
             <http://github.com/fnva>
             <http://twitter.com/ferran_vila>
             <mailto:ferran.vila.conesa@gmail.com>

    * See source code files for contributors.

Release:

    * @version v2.0.2

-------------------------------------------| aut inveniam viam aut faciam |--------------------------------------------
*/

/**
   Interface for Managing the Globalization results

   @author Francisco Javier Martin Bueno
   @since ARP1.0
   @version 1.0
*/
public protocol IGlobalization : IBaseApplication {
     /**
        List of supported locales for the application

        @return List of locales
        @since ARP1.0
     */
     func getLocaleSupportedDescriptors() -> [Locale] 

     /**
        Gets the text/message corresponding to the given key and locale.

        @param key    to match text
        @param locale The locale object to get localized message, or the locale desciptor ("language" or "language-country" two-letters ISO codes.
        @return Localized text.
        @since ARP1.0
     */
     func getResourceLiteral(key : String, locale : Locale) -> String 

     /**
        Gets the full application configured literals (key/message pairs) corresponding to the given locale.

        @param locale The locale object to get localized message, or the locale desciptor ("language" or "language-country" two-letters ISO codes.
        @return Localized texts in the form of an object.
        @since ARP1.0
     */
     func getResourceLiterals(locale : Locale) -> [KeyPair] 

}

/**
------------------------------------| Engineered with ♥ in Barcelona, Catalonia |--------------------------------------
*/
