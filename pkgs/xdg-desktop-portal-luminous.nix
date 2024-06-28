{
  lib,
  stdenv,
  clang,
  cargo,
  cmake,
  rustc,
  libxkbcommon,
  glib,
  inih,
  pango,
  cairo,
  fetchFromGitHub,
  meson,
  ninja,
  pkg-config,
  pipewire,
  slurp,
  wayland,
  wayland-protocols,
  wayland-scanner,
}:
stdenv.mkDerivation rec {
  pname = "xdg-desktop-portal-luminous";
  version = "0.1.4";

  src = fetchFromGitHub {
    owner = "waycrates";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-GIIDeZMIGUiZV0IUhcclRVThE5LKaqVc5VwnNT8beNU=";
  };

  strictDeps = true;
  depsBuildBuild = [pkg-config];
  nativeBuildInputs = [
    cairo
    cargo
    clang
    # cmake
    glib
    libxkbcommon
    meson
    ninja
    pango
    pipewire
    pkg-config
    rustc
    stdenv
    wayland
    wayland-scanner
  ];
  buildInputs = [
    inih
    wayland-protocols
  ];

  postInstall = ''
    wrapProgram $out/libexec/xdg-desktop-portal-wlr --prefix PATH ":" ${lib.makeBinPath [slurp]}
  '';

  meta = with lib; {
    homepage = "https://github.com/emersion/xdg-desktop-portal-wlr";
    description = "xdg-desktop-portal backend for wlroots";
    maintainers = with maintainers; [redbeardymcgee];
    platforms = platforms.linux;
    license = licenses.gpl3;
  };
}
