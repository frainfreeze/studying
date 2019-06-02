# FAQ
Q: How do i build documentation<br/>
A: run `mvn site:site`

Q: log4j cant find configuration but it is there<br/>
A: got to java build path in project properties and make sure src/main/resources has excluded set to none

Q: maven test: log4j cant find configuration but it is there<br/>
A: Set resources in pom.xml

Q: No compiler is provided in this environment. Perhaps you are running on a JRE rather than a JDK?<br/>
A: install new jre and jdk

Q: Error: Could not find or load main class ...<br/>
A: Right click on project > maven > update project

Q: Resource specification not allowed here for source level below 1.7<br/>
A: Change project compliance and JRE to 1.7