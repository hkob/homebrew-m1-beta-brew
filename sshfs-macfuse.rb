class SshfsMacfuse < Formula
  desc "File system client based on SSH File Transfer Protocol"
  homepage "https://osxfuse.github.io/"
  url "https://github.com/libfuse/sshfs/releases/download/sshfs-2.10/sshfs-2.10.tar.gz"
  sha256 "70845dde2d70606aa207db5edfe878e266f9c193f1956dd10ba1b7e9a3c8d101"
  license "GPL-2.0-or-later"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build
  depends_on "glib"
  depends_on "cask" => "macfuse-arm64"

  patch do
    url "https://github.com/libfuse/sshfs/commit/667cf34622e2e873db776791df275c7a582d6295.patch?full_index=1"
    sha256 "ab2aa697d66457bf8a3f469e89572165b58edb0771aa1e9c2070f54071fad5f6"
  end

  patch :p0, :DATA

  def install
    system "./configure", "--disable-dependency-tracking", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system "#{bin}/sshfs", "--version"
  end
end
__END__
--- sshfs.c.orig	2020-12-03 10:32:25.000000000 +0900
+++ sshfs.c	2020-12-03 10:32:42.000000000 +0900
@@ -14,9 +14,6 @@
 #if !defined(__CYGWIN__)
 #include <fuse_lowlevel.h>
 #endif
-#ifdef __APPLE__
-#  include <fuse_darwin.h>
-#endif
 #include <assert.h>
 #include <stdio.h>
 #include <stdlib.h>
