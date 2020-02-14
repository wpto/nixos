{ config, lib, pkgs, ... }:

with lib;

let

  mount-file = submodule (
    {name, config, ...}:
    { options = {

        enable = mkOption {
          type = types.bool;
          default = true;
          description = "";  
        };

        target = mkOption {
          type = types.str;
          description = "Name of symlink"; 
        # default = "from name";
        };

        text = mkOption {
          default = null;
          type = types.nullOr types.lines;
          description = "Text of the file.";
        };

        source = mkOption {
          type = types.path;
          description = "Path of the source file";
        };

        mode = mkOption {
          type = types.str;
          default = "symlink";
          example = "0600";
          description = "symlink or copy";
        };

        uid = mkOption {
          default = 0;
          type = types.int;
          description = ''
            UID of created file. Only takes affect when the file is
            copied (that is, the mode is not 'symlink').
          '';
        };

        gid = mkOption {
          default = 0;
          type = types.int;
          description = ''
            GID of created file. Only takes affect when the file is
            copied (that is, the mode is not 'symlink').
          '';
        };

        user = mkOption {
          default = "+${toString config.uid}";
          type = types.str;
          description = ''
            User name of created file.
            Only takes affect when the file is copied (that is, the mode is not 'symlink').
            Changing this option takes precedence over <literal>uid</literal>.
          '';
        };

        group = mkOption {
          default = "+${toString config.gid}";
          type = types.str;
          description = ''
            Group name of created file.
            Only takes affect when the file is copied (that is, the mode is not 'symlink').
            Changing this option takes precedence over <literal>gid</literal>.
          '';
        };
      };

      config = {
        target = mkDefault name;
        source = mkIf (config.text != null) (
          let name' = "some-" + baseNameOf name;
          in mkDefault (pkgs.writeText name' config.text));
      };

    }


in 

{

  options = {
    homemount = mkOption {
      default = [];
      example = "";
      description = "";
      type = with types; nullOr (listOf str);
    };
  };

  config = {
    
  };
}
