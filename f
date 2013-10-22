[1mdiff --git a/ea-template/src/main/resources/database-${online}.properties b/ea-template/src/main/resources/database-${online}.properties[m
[1mindex 2e65e54..86a0666 100644[m
[1m--- a/ea-template/src/main/resources/database-${online}.properties[m
[1m+++ b/ea-template/src/main/resources/database-${online}.properties[m
[36m@@ -8,7 +8,7 @@[m [mea.jdbc.password=[m
 ea.jdbc.maxIdle=10[m
 ea.jdbc.maxActive=30[m
 ea.jdbc.maxWait=60000[m
[31m-ea.hibernate.hbm2ddl=update[m
[32m+[m[32mea.hibernate.hbm2ddl=create[m
 ea.hibernate.show_sql=true[m
 ea.hibernate.jdbc.fetch_size=50[m
 ea.hibernate.cache.provider_class=org.hibernate.cache.EhCacheProvider[m
[1mdiff --git a/ea-template/tom.txt b/ea-template/tom.txt[m
[1mindex d1d06ad..55f3ed9 100644[m
[1m--- a/ea-template/tom.txt[m
[1m+++ b/ea-template/tom.txt[m
[36m@@ -1 +1 @@[m
[31m-1111[m
\ No newline at end of file[m
[32m+[m[32m22221111[m
\ No newline at end of file[m
