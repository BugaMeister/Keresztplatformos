// Az egyes útvonalak belső reprezentációja
class MeetingsRoutePath {
  bool isUnknown;
  bool isProfile;

  MeetingsRoutePath.home()
      : isUnknown = false,
        isProfile = false;

  MeetingsRoutePath.unknown()
      : isUnknown = true,
        isProfile = false;

  MeetingsRoutePath.rooms()
      : isUnknown = false,
        isProfile = true;

  bool get isHomePage => !isProfile;
}
