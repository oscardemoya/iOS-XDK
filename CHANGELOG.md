# LayerXDK Changelog

## 4.1.0-pre1

### Enhancements

* Adds support for audio and video messages, including the large size variants. [IOS-3378], [IOS-3387]
* Adds support for analytics events which is available in LayerKit SDK. [IOS-3428]

### Known issues for 4.1.0-pre1

* XDK-UI: General - A bunch of `NSConstraint` violations related to feedback messages. [IOS-3474]
* XDK-UI: General - Message cell sizing problems for messages containing photos. [IOS-3469]
* XDK-UI: Audio - Audio and Video message cells can have undefined sizing, if missing or partial size information. [IOS-3465]
* XDK-UI: Audio - Missing margins in the large message variant. [IOS-3468]
* XDK-UI: Video - Preview posters not cropped correctly. [IOS-3471]
* XDK-UI: Video - No black background when poster is missing. [IOS-3472]
* XDK-UI: Video - Add fullscreen support. [IOS-3473]
* XDK-UI: Feedback - Transfer star rating from the medium size message to large size when selecting it from the conversation view. [IOS-3459]
* XDK-UI: Feedback - Experience rating with button action embedded in the message metadata disables rating. [IOS-3461]
* XDK-UI: Feedback - Feedback message embedded in a carousel is wider than standalone. [IOS-3462]
* XDK-UI: Feedback - Send button not hidden after submitting. [IOS-3463]
* XDK-UI: Feedback - Persist local state if feedback not submitted yet, and use `localData` on `LYRMessage` to persist state before it roundtrips from the server. [IOS-3464]
* XDK-UI: Feedback - Close large feedback message after submitting. [IOS-3460]

## 4.0.2

### Enhancements

* Added an ability to register message presenters for different size variants. [IOS-3425]

## 4.0.1

### Public API Changes

* Changed the `LYRUIProductMessage` object's `price` property from `double` to `NSNumber` to support null values. This also affects the corresponding `LYRUIProductMessageSerializer` and `LYRUIProductMessageCompositeViewPresenter` classes. [IOS-3420]

### Enhancements

* Support for sending messages with a single link (URL). [IOS-3362]
* Adds sender's name for incoming messages. [IOS-3412]

### Bug fixes

* Fixed message status to display as `sent` instead of `pending` when the current user is the only participant in a conversation. [IOS-3419]
* Fixed image orientation when choosing 'Take Photo' from the compose bar. [IOS-3421]

## 4.0.0

### Enhancements

* Messages are moved to the bottom of messages list
* Added conflict resolution to choice messages and choice buttons
* Improved keyboard hiding and animations in conversation view

### Bug fixes

* Fixed support for legacy message types
* Fixed crash when going out from conversation on iOS 10
* Fixed multiple minor UI issues

## 1.0.0-pre2

### Enhancements

* Added 3d touch preview of message actions
* Added methods for adding custom message types
* Added persistence of selections in Choice Message and Choice Button when selecting offline

### Bug fixes

* Fixed crash in `LYRUIMessageListView` when presenting `LYRConversation` without any messages
* Added selected state to the `LYRUIIdentityListView` items
* Fixed persistence of Carousel message content offset
* Fixed updating message statuses in `LYRUIMessageListView`
* Fixed input field and send button state in `LYRUIConversationView` after sending a message
* Fixed sending message responses
* Fixed multiple UI layout issues

## 1.0.0-pre1

### Initial release
