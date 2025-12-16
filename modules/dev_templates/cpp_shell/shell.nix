{pkgs, ...}: {
  packages = with pkgs; [
    clang-tools
    lldb
    cmake
  ];
}
