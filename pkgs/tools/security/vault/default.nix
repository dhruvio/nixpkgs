{ stdenv, fetchFromGitHub, buildGoPackage }:

buildGoPackage rec {
  pname = "vault";
  version = "1.2.3";

  src = fetchFromGitHub {
    owner = "hashicorp";
    repo = "vault";
    rev = "v${version}";
    sha256 = "11zi12j09vi6j112a1n8f7sxwp15pbh0801bzh27ihcy01hlzdf8";
  };

  goPackagePath = "github.com/hashicorp/vault";

  subPackages = [ "." ];

  buildFlagsArray = [
    "-tags='vault'"
    "-ldflags=\"-X github.com/hashicorp/vault/sdk/version.GitCommit='v${version}'\""
  ];

  postInstall = ''
    mkdir -p $bin/share/bash-completion/completions
    echo "complete -C $bin/bin/vault vault" > $bin/share/bash-completion/completions/vault
  '';

  meta = with stdenv.lib; {
    homepage = https://www.vaultproject.io;
    description = "A tool for managing secrets";
    platforms = platforms.linux ++ platforms.darwin;
    license = licenses.mpl20;
    maintainers = with maintainers; [ rushmorem lnl7 offline pradeepchhetri ];
  };
}
