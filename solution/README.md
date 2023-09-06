# parser

## environment
```
// mvn
Apache Maven 3.2.5 (12a6b3acb947671f09b81f49094c53f426d8cea1; 2014-12-14T12:29:23-05:00)
OS name: "mac os x", version: "13.2.1", arch: "x86_64", family: "mac"

// java
openjdk 20.0.2 2023-07-18
OpenJDK Runtime Environment Temurin-20.0.2+9 (build 20.0.2+9)
OpenJDK 64-Bit Server VM Temurin-20.0.2+9 (build 20.0.2+9, mixed mode, sharing)
```

I am running java 20 but compiled code _should_ work on lower versions too

## Compile
`mvn clean compile install package`

## Run
`java -jar target/parser-1.0-SNAPSHOT-jar-with-dependencies.jar`

Json output is written to stdout and dumped to a file out.json
Stdout can be piped to jq for nicer results

## Other option
`mvn exec:java`

## Run in IDE

Kotlin works best with intellij [no vscode]

Load the entire project as a maven project in intellij and run it by the main
function directly