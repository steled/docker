#!/bin/bash

mkdir /tmp/installmonit
cd /tmp/installmonit

wget http://ubuntu-master.mirror.tudos.de/ubuntu/pool/universe/m/monit/monit_5.25.2-1.dsc
wget http://ubuntu-master.mirror.tudos.de/ubuntu/pool/universe/m/monit/monit_5.25.2.orig.tar.gz
wget http://ubuntu-master.mirror.tudos.de/ubuntu/pool/universe/m/monit/monit_5.25.2-1.debian.tar.xz

#tar xzf $(find /tmp/installmonit/ -name *.orig.tar.gz -printf "%f\n")
tar xzf *.orig.tar.gz

cd $(find /tmp/installmonit/ -type d -name monit-*)
#tar xJf $(find /tmp/installmonit/ -name *.debian.tar.xz)
tar xJf ../*.debian.tar.xz

cat > debian/patches/99_local-emp.patch <<__EOF__
--- a/src/ssl/Ssl.h 2017-04-19 15:19:49.000000000 +0200
+++ b/src/ssl/Ssl.h 2017-05-15 14:23:37.481176405 +0200
@@ -68,7 +68,7 @@
 /*
  * The list of all ciphers suites in order of strength except those containing anonymous DH ciphers, low bit-size ciphers, export-crippled ciphersm the MD5 hash algorithm and weak DES, RC4 and 3DES ciphers.
  */
-#define CIPHER_LIST "ALL:!DES:!RC4:!aNULL:!LOW:!EXP:!IDEA:!MD5:!3DES:@STRENGTH"
+#define CIPHER_LIST "AES:!aNULL:!LOW:!EXP:!IDEA:!MD5:!3DES:@STRENGTH"
 
 
 /**
--- a/src/ssl/Ssl.c 2017-04-19 15:19:49.000000000 +0200
+++ b/src/ssl/Ssl.c 2017-05-15 14:22:59.693359795 +0200
@@ -842,7 +842,7 @@
                 EC_KEY_free(key);
         }
 #endif
-        SSL_CTX_set_options(S->ctx, SSL_OP_NO_SSLv2 | SSL_OP_NO_SSLv3);
+        SSL_CTX_set_options(S->ctx, SSL_OP_NO_SSLv2 | SSL_OP_NO_SSLv3 | SSL_OP_NO_TLSv1);
 #ifdef SSL_OP_NO_COMPRESSION
         SSL_CTX_set_options(S->ctx, SSL_OP_NO_COMPRESSION);
 #endif
__EOF__

echo " 99_local-emp.patch" >> debian/patches/series

dch -n "Added patch for sensible ciphers and to disable TLSv1"
debuild -d

cd ..
fpm -s deb -t deb -n monit-emp $(ls -1t monit_*.deb | head -1)

mv $(find /tmp/installmonit/ -name "monit-emp*.deb") /tmp