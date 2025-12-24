# User configuration
{
  config,
  lib,
  ...
}: {
  options = {
    username = lib.mkOption {
      type = lib.types.str;
      description = "My username as shown by `id -un`";
    };
    fullname = lib.mkOption {
      type = lib.types.str;
      description = "My full name used in my Git config";
    };
    email = lib.mkOption {
      type = lib.types.str;
      description = "My email used in my Git config";
    };
    what = lib.mkOption {
      type = lib.types.bool;
      description = "Whether this ho";
    };
  };

  config = {
    home.username = config.me.username;
  };
}
