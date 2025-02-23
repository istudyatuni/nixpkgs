{
  lib,
  stdenv,
  fetchFromGitHub,
  cmake,
  SDL3,
}:
stdenv.mkDerivation rec {
  pname = "fna3d";
  version = "25.02-SDL3";

  src = fetchFromGitHub {
    owner = "FNA-XNA";
    repo = "FNA3D";
    rev = version;
    fetchSubmodules = true;
    hash = "sha256-0rRwIbOciPepo+ApvJiK5IyhMdq/4jsMlCSv0UeDETs=";
  };

  buildInputs = [ SDL3 ];
  nativeBuildInputs = [ cmake ];

  cmakeFlags = [
    "-DBUILD_SDL3=ON"
  ];

  installPhase = ''
    runHook preInstall
    install -Dm755 libFNA3D.so $out/lib/libFNA3D.so
    ln -s libFNA3D.so $out/lib/libFNA3D.so.0
    ln -s libFNA3D.so $out/lib/libFNA3D.so.0.${version}
    runHook postInstall
  '';

  meta = {
    description = "Accuracy-focused XNA4 reimplementation for open platforms";
    homepage = "https://fna-xna.github.io/";
    license = lib.licenses.mspl;
    platforms = lib.platforms.linux;
    mainProgram = pname;
    maintainers = with lib.maintainers; [ mrtnvgr ];
  };
}
