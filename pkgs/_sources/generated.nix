# This file was generated by nvfetcher, please do not modify it manually.
{ fetchgit, fetchurl, fetchFromGitHub, dockerTools }:
{
  cats-blender-plugin-unofficial = {
    pname = "cats-blender-plugin-unofficial";
    version = "45032046e3e77a0a397fe1dc482f68cb5444dc59";
    src = fetchgit {
      url = "https://github.com/teamneoneko/Cats-Blender-Plugin-Unofficial-.git";
      rev = "45032046e3e77a0a397fe1dc482f68cb5444dc59";
      fetchSubmodules = false;
      deepClone = false;
      leaveDotGit = false;
      sparseCheckout = [ ];
      sha256 = "sha256-8n5VI2kAdxmuapSmiHtG2yrwy3wvtksbVtQ29cys2j8=";
    };
    date = "2025-03-26";
  };
  wivrn-solarxr = {
    pname = "wivrn-solarxr";
    version = "52ad3fa19ba8fe6a12fcca20d2794a414fc0a20c";
    src = fetchFromGitHub {
      owner = "notpeelz";
      repo = "WiVRn";
      rev = "52ad3fa19ba8fe6a12fcca20d2794a414fc0a20c";
      fetchSubmodules = false;
      sha256 = "sha256-ZWox2mc/Y/n1ewaCed7d5VK+MCzzpjCq5yuvV2iqsyY=";
    };
    date = "2025-05-18";
  };
}
