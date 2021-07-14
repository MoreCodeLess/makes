{ toJSONFile
, ...
}:
{ config
, lib
, ...
}:
{
  options = {
    cache = {
      enable = lib.mkOption {
        default = false;
        type = lib.types.bool;
      };
      name = lib.mkOption {
        type = lib.types.str;
      };
      pubKey = lib.mkOption {
        type = lib.types.str;
      };
    };
    cacheAsJson = lib.mkOption {
      type = lib.types.package;
    };
  };
  config = {
    cacheAsJson = toJSONFile "cache.json"
      (lib.optionalAttrs config.cache.enable {
        name = config.cache.name;
        url = "https://${config.cache.name}.cachix.org";
        pubKey = config.cache.pubKey;
      });
  };
}