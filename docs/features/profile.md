# Profile (example)

Files: `lib/ui/features/profile/`, `lib/domain/repositories/user_repository.dart`, `lib/data/repositories/user_repository_impl.dart`, `lib/data/services/remote/user_api_service.dart`, `lib/data/services/platform/image_picker_service.dart`.

## Profile tab (`/home/profile`)

The user comes from `sessionProvider`; `ProfileNotifier` only runs actions. On open it fetches the full user (`GET auth/me`: login returns a short one) silently; pull to refresh does it with error toasts. The screen shows the avatar card, task counts (from `todosProvider`), username/email/phone, **Edit profile** and **Log out**.

## Edit profile (`/profile/edit`)

`EditProfileNotifier` starts from the current user. **Change photo** opens the gallery through `UserRepository.pickAvatar()` (`ImagePickerService`, resized to 512px, returned as bytes so it works on web too); **Remove photo** clears it. **Save** validates first name, last name, email and optional phone, then `UserRepository.update` sends `PUT users/{id}` and stores the user (with the photo bytes) in the session. The demo API doesn't persist writes, so the device copy is the truth.
