# Tutorials

## Misc

To rebuild documentation run `mvn clean site`

## Documentation

- https://softwareriot.wordpress.com/2017/09/06/better-site-documentation-with-maven-part-i-the-fluido-skin/
- https://softwareriot.wordpress.com/2017/09/13/better-site-documentation-with-maven-part-ii-adding-markdown-pages/

todo:

- https://softwareriot.wordpress.com/2017/09/14/better-site-documentation-with-maven-part-iii-adding-dependency-reports/
- https://softwareriot.wordpress.com/2017/09/15/better-site-documentation-with-maven-part-iv-static-code-analysis-with-findbugs/
- https://softwareriot.wordpress.com/2017/09/20/better-site-documentation-with-maven-part-v-static-code-analysis-with-pmd/

## FAQ
Q: log4j cant find configuration but it is there
A: got to java build path in project properties and make sure src/main/resources has excluded set to none

Q: maven test: log4j cant find configuration but it is there
A: Set resources in pom.xml

Q: No compiler is provided in this environment. Perhaps you are running on a JRE rather than a JDK?
A: install new jre and jdk