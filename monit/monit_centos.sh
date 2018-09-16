#!/bin/bash

mkdir /tmp/installmonit
cd /tmp/installmonit/

wget https://mmonit.com/monit/dist/monit-5.25.2.tar.gz
#tar xzvf $(find /tmp/installmonit/ -name "*.tar.gz" -printf "%f\n")
tar xzvf *.tar.gz

cat > 99_local-emp.patch <<__EOF__
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

#cd monit-*
cd $(find /tmp/installmonit -type d -name "monit-*")
patch -p1 < ../99_local-emp.patch
cd ..

tar czvf $(find /tmp/installmonit -type f -name "monit-*" | awk -F / '{ print $4 }' | sed 's/monit-/monit-emp_/') $(find /tmp/installmonit -type d -name "monit-*" | awk -F / '{ print $4 }')

cd ~
rpmdev-setuptree
cd /tmp/installmonit/
#cp monit-emp_*.tar.gz ~/rpmbuild/SOURCES/monit-*.tar.gz
cp $(find /tmp/installmonit -type f -name "monit-emp*" | awk -F / '{ print $4 }') ~/rpmbuild/SOURCES/$(find /tmp/installmonit -type d -name "monit-*" | awk -F / '{ print $4 }').tar.gz
# cp monit-5.25.2.tar.gz ~/rpmbuild/SOURCES
#rpmbuild -bb monit-*/system/packages/redhat/monit.spec
rpmbuild -bb $(find /tmp/installmonit -type d -name "monit-*" | awk -F / '{ print $4 }')/system/packages/redhat/monit.spec
#mv ~/rpmbuild/RPMS/x86_64/monit-*-1.x86_64.rpm /tmp/installmonit
mv $(find ~/rpmbuild/RPMS/x86_64/ -type f -not -name "monit-debug*") /tmp