# keystore-helper

Bash script to recreate a java keystore for local development use.

## How-To

from within a shell console (git bash for example)

```shell
./generate-keystore.sh
```

A file __keystore.jks__ will be generated. this file can be used as a keystore for starting up tomcat or other services locally.
can also have any required maven repo certificates

### Sample Tomcat Jvm Args
#### Same for your MAVEN_OPS environment variable

```java
-Djavax.net.ssl.keyStore="C:\development\workspace\keystore-helper\keystore.jks"
-Djavax.net.ssl.keyStorePassword=123456
-Djavax.net.ssl.trustStore="C:\development\workspace\keystore-helper\keystore.jks"
-Djavax.net.ssl.trustStorePassword=123456
```