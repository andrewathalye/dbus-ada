{ pkgs ? import <nixpkgs> {} }:

with pkgs;
pkgs.mkShell {
  nativeBuildInputs = [ gnat gprbuild ];
  buildInputs = [ dbus dbus-glib ];
}
