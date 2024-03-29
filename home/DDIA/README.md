# Designing Data-Intensive Applications
## The Big Ideas Behind Reliable, Scalable, and Maintainable Systems


## Part I: Foundations of Data Systems

----

Three concerns that are important in most software systems:
- Reliability: The system should continue to work correctly (performing the correct 
  function at the desired level of performance) even in the face of adversity (hardware 
  or software faults, and even human error)
- Scalability: As the system grows (in data volume, traffic volume, or complexity), 
  there should be reasonable ways of dealing with that growth.
- Maintainability: Over time, many different people will work on the system (engineering 
  and operations, both maintaining current behavior and adapting the system to new use
  cases), and they should all be able to work on it productively.

## Ch. 1: Reliable, Scalable, and Maintainable Applications

A data-intensive application is typically built from standard building blocks that 
provide commonly needed functionality. For example, many applications need to:
- Store data so that they, or another application, can find it again later (databases)
- Remember the result of an expensive operation, to speed up reads (caches)
- Allow users to search data by keyword or filter it in various ways (search indexes)
- Send a message to another process, to be handled asynchronously (stream processing)
- Periodically crunch a large amount of accumulated data (batch processing)

![figure 1-1](https://i.imgur.com/OCm54FT.png)


### Reliability
A fault is usually defined as one component of the system deviating from its spec, 
whereas a failure is when the system as a whole stops providing the required service 
to the user. It is impossible to reduce the probability of a fault to zero; therefore 
it is usually best to design fault-tolerance mechanisms that prevent faults from causing 
failures.

We generally prefer tolerating faults over preventing faults.

By deliberately inducing faults, you ensure that the fault-tolerance
machinery is continually exercised and tested, which can increase your confidence
that faults will be handled correctly when they occur naturally.
The example of this is the Netflix Chaos Moneky.

There is no quick solution to the problem of systematic faults in software. Lots of
small things can help: carefully thinking about assumptions and interactions in the
system; thorough testing; process isolation; allowing processes to crash and restart;
measuring, monitoring, and analyzing system behavior in production. If a system is
expected to provide some guarantee (for example, in a message queue, that the number 
of incoming messages equals the number of outgoing messages), it can constantly
check itself while it is running and raise an alert if a discrepancy is found.

To avoid human error the best systems combine several approaches:
- Decouple the places where people make the most mistakes from the places where
they can cause failures. In particular, provide fully featured non-production
sandbox environments where people can explore and experiment safely, using
real data, without affecting real users.
- Design APIs and Admin interfaces in a way that minimizes opportunities for error.
- Test thoroughly at all levels, from unit tests to whole-system integration tests and
  manual tests.
- Allow quick and easy recovery from human errors, to minimize the impact in the
  case of a failure. For example, make it fast to roll back configuration changes, roll
  out new code gradually (so that any unexpected bugs affect only a small subset of
  users), and provide tools to recompute data (in case it turns out that the old 
  computation was incorrect).
- Set up detailed and clear monitoring, such as performance metrics and error
  rates. In other engineering disciplines this is referred to as telemetry.
- Implement good management practices and training.

There are situations in which we may choose to sacrifice reliability in order to reduce
development cost (e.g., when developing a prototype product for an unproven market) or 
operational cost (e.g., for a service with a very narrow profit margin) — but we
should be very conscious of when we are cutting corners (tech debt). Idea is to serve
the business needs if software is being developed for profit.

### Scalability
Sscalability means considering questions like “If the system grows in a particular way,
what are our options for coping with the growth?” and “How can we add computing
resources to handle the additional load?”

Load can be described with a few numbers which we call **load parameters**. The best 
choice of parameters depends on the architecture of your system: it may be requests 
per second to a web server, the ratio of reads to writes in a database, the number of 
simultaneously active users in a chat room, the hit rate on a cache, or something else. 
Perhaps the average case is what matters for you, or perhaps your bottleneck is dominated 
by a small number of extreme cases.

Latency and response time are often used synonymously, but they
are not the same. The response time is what the client sees: besides
the actual time to process the request (the service time), it includes
network delays and queueing delays. Latency is the duration that a
request is waiting to be handled—during which it is latent, awaiting service.

We need to think of response time as a distribution of values that you can measure.

![figure 1-4](https://i.imgur.com/Ci4L67n.png)

Median is a good metric if you want to know how long users typically
have to wait: half of user requests are served in less than the median response time,
and the other half take longer than the median. The median is also known as the 50th
percentile, and sometimes abbreviated as p50. Note that the median refers to a single
request; if the user makes several requests (over the course of a session, or because
several resources are included in a single page), the probability that at least one of
them is slower than the median is much greater than 50%.

In order to figure out how bad your outliers are, you can look at higher percentiles:
the 95th, 99th, and 99.9th percentiles are common (abbreviated p95, p99, and p999).
They are the response time thresholds at which 95%, 99%, or 99.9% of requests are
faster than that particular threshold. For example, if the 95th percentile response time
is 1.5 seconds, that means 95 out of 100 requests take less than 1.5 seconds, and 5 out
of 100 requests take 1.5 seconds or more. This is illustrated in Figure 1-4.

High percentiles of response times, also known as **tail latencies**, are important
because they directly affect users’ experience of the service. For example, Amazon
describes response time requirements for internal services in terms of the 99.9th per‐
centile, even though it only affects 1 in 1,000 requests. This is because the customers
with the slowest requests are often those who have the most data on their accounts
because they have made many purchases—that is, they’re the most valuable custom‐
ers. It’s important to keep those customers happy by ensuring the website is fast
for them: Amazon has also observed that a 100 ms increase in response time reduces
sales by 1%, and others report that a 1-second slowdown reduces a customer sat‐
isfaction metric by 16%.

Percentiles are often used in service level objectives (SLOs) and service level 
agreements (SLAs), contracts that define the expected performance and availability 
of a service.


Queueing delays often account for a large part of the response time at high percen‐
tiles. As a server can only process a small number of things in parallel (limited, for
example, by its number of CPU cores), it only takes a small number of slow requests
to hold up the processing of subsequent requests—an effect sometimes known as
**head-of-line blocking**. Even if those subsequent requests are fast to process on the
server, the client will see a slow overall response time due to the time waiting for the
prior request to complete. Due to this effect, it is important to measure response
times on the client side and be mindful to keep sending requests independently of response
time when generating load artificially in order to test the scalability of a system.



#### Percentiles in practice

![figure 1-5](https://i.imgur.com/N3PS83w.png)

High percentiles become especially important in backend services that are called multiple 
times as part of serving a single end-user request. Even if you make the calls in parallel, 
the end-user request still needs to wait for the slowest of the parallel calls to complete. 
It takes just one slow call to make the entire end-user request slow, as illustrated in Figure 1-5. 
Even if only a small percentage of backend calls are slow, the chance of getting a slow call 
increases if an end-user request requires multiple backend calls, and so a higher proportion 
of end-user requests end up being slow (an effect known as **tail latency amplification**).

If you want to add response time percentiles to the monitoring dashboards for your
services, you need to efficiently calculate them on an ongoing basis. For example, you
may want to keep a rolling window of response times of requests in the last 10 minutes. 
Every minute, you calculate the median and various percentiles over the values in that 
window and plot those metrics on a graph. The naïve implementation is to keep a list of 
response times for all requests within the time window and to sort that list every minute. 
If that is too inefficient for you, there are algorithms that can calculate a good approximation 
of percentiles at minimal CPU and memory cost, such as **forward decay**, **t-digest**, 
or **HdrHistogram**. 

Beware that averaging percentiles, e.g., to reduce the time resolution or to combine data from 
several machines, is mathematically meaningless — the right way of aggregating response time data 
is to add the histograms.


### Maintainability

- Operability: Making Life Easy for Operations
- Simplicity: Minimize (accidental) Complexity, use abstraction
- Evolvability: Making Change Easy, Agile, TDD



<details>
  <summary>References</summary>

  1.  Michael Stonebraker and Uğur Çetintemel:
      “['One Size Fits All': An Idea Whose Time Has Come and Gone](http://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.68.9136&rep=rep1&type=pdf),” at *21st International Conference
      on Data Engineering* (ICDE), April 2005.

  1.  Walter L. Heimerdinger and Charles B. Weinstock:
      “[A Conceptual Framework for System Fault Tolerance](https://resources.sei.cmu.edu/asset_files/TechnicalReport/1992_005_001_16112.pdf),” Technical Report CMU/SEI-92-TR-033, Software Engineering Institute, Carnegie
      Mellon University, October 1992.

  1.  Ding Yuan, Yu Luo, Xin Zhuang, et al.:
      “[Simple Testing Can Prevent Most Critical Failures: An Analysis of Production Failures in Distributed Data-Intensive Systems](https://www.usenix.org/system/files/conference/osdi14/osdi14-paper-yuan.pdf),” at *11th USENIX Symposium on Operating Systems Design
      and Implementation* (OSDI), October 2014.

  1.  Yury Izrailevsky and Ariel Tseitlin:
      “[The Netflix Simian Army](https://netflixtechblog.com/the-netflix-simian-army-16e57fbab116),”
      *netflixtechblog.com*, July 19, 2011.

  1.  Daniel Ford, François Labelle, Florentina I. Popovici, et al.:
      “[Availability in Globally Distributed Storage Systems](http://research.google.com/pubs/archive/36737.pdf),”
      at *9th USENIX Symposium on Operating Systems Design and Implementation* (OSDI),
      October 2010.

  1.  Brian Beach:
      “[Hard Drive Reliability Update – Sep 2014](https://www.backblaze.com/blog/hard-drive-reliability-update-september-2014/),” *backblaze.com*, September 23, 2014.

  1.  Laurie Voss:
      “[AWS: The Good, the Bad and the Ugly](https://web.archive.org/web/20160429075023/http://blog.awe.sm/2012/12/18/aws-the-good-the-bad-and-the-ugly/),” *blog.awe.sm*, December 18, 2012.

  1.  Haryadi S. Gunawi, Mingzhe Hao, Tanakorn
      Leesatapornwongsa, et al.: “[What Bugs Live in the Cloud?](http://ucare.cs.uchicago.edu/pdf/socc14-cbs.pdf),” at *5th ACM Symposium on Cloud Computing* (SoCC), November 2014.
      [doi:10.1145/2670979.2670986](http://dx.doi.org/10.1145/2670979.2670986)

  1.  Nelson Minar:
        “[Leap Second Crashes Half   the Internet](http://www.somebits.com/weblog/tech/bad/leap-second-2012.html),” *somebits.com*, July 3, 2012.

  1.  Amazon Web Services:
        “[Summary of the Amazon EC2 and Amazon RDS Service   Disruption in the US East Region](http://aws.amazon.com/message/65648/),” *aws.amazon.com*, April 29, 2011.

  1.  Richard I. Cook:
      “[How Complex Systems Fail](http://web.mit.edu/2.75/resources/random/How%20Complex%20Systems%20Fail.pdf),” Cognitive Technologies Laboratory, April 2000.

  1.  Jay Kreps:
      “[Getting Real About Distributed System Reliability](http://blog.empathybox.com/post/19574936361/getting-real-about-distributed-system-reliability),” *blog.empathybox.com*, March 19, 2012.

  1.  David Oppenheimer, Archana Ganapathi, and David A. Patterson:
      “[Why Do Internet Services Fail, and What Can Be Done About It?](http://static.usenix.org/legacy/events/usits03/tech/full_papers/oppenheimer/oppenheimer.pdf),” at *4th USENIX Symposium on
      Internet Technologies and Systems* (USITS), March 2003.

  1.  Nathan Marz:
        “[Principles   of Software Engineering, Part 1](http://nathanmarz.com/blog/principles-of-software-engineering-part-1.html),” *nathanmarz.com*, April 2, 2013.

  1.  Michael Jurewitz:
      “[The Human Impact of Bugs](http://jury.me/blog/2013/3/14/the-human-impact-of-bugs),”
      *jury.me*, March 15, 2013.

  1.  Raffi Krikorian:
      “[Timelines at Scale](http://www.infoq.com/presentations/Twitter-Timeline-Scalability),”
      at *QCon San Francisco*, November 2012.

  1.  Martin Fowler:
      *Patterns of Enterprise Application Architecture*. Addison Wesley, 2002.
      ISBN: 978-0-321-12742-6

  1.  Kelly Sommers:
      “[After all that run around, what caused 500ms disk latency even when we replaced physical server?](https://twitter.com/kellabyte/status/532930540777635840)” *twitter.com*, November 13, 2014.

  1.  Giuseppe DeCandia, Deniz Hastorun, Madan Jampani, et al.:
      “[Dynamo: Amazon's Highly Available Key-Value Store](http://www.allthingsdistributed.com/files/amazon-dynamo-sosp2007.pdf),” at *21st ACM Symposium on Operating
      Systems Principles* (SOSP), October 2007.

  1.  Greg Linden:
      “[Make Data Useful](http://glinden.blogspot.co.uk/2006/12/slides-from-my-talk-at-stanford.html),” slides from presentation at Stanford University Data Mining class (CS345), December 2006.

  1.  Tammy Everts:
      “[The Real Cost of Slow Time vs Downtime](https://www.slideshare.net/Radware/radware-cmg2014-tammyevertsslowtimevsdowntime),” *slideshare.net*, November 5, 2014.

  1.  Jake Brutlag:
      “[Speed Matters](https://ai.googleblog.com/2009/06/speed-matters.html),” *ai.googleblog.com*, June 23, 2009.

  1.  Tyler Treat:
      “[Everything You Know About Latency Is Wrong](http://bravenewgeek.com/everything-you-know-about-latency-is-wrong/),” *bravenewgeek.com*, December 12, 2015.

  1.  Jeffrey Dean and Luiz André Barroso:
      “[The Tail at Scale](http://cacm.acm.org/magazines/2013/2/160173-the-tail-at-scale/fulltext),”
      *Communications of the ACM*, volume 56, number 2, pages 74–80, February 2013.
      [doi:10.1145/2408776.2408794](http://dx.doi.org/10.1145/2408776.2408794)

  1.  Graham Cormode, Vladislav
      Shkapenyuk, Divesh Srivastava, and Bojian Xu:
      “[Forward Decay: A Practical Time Decay Model for Streaming Systems](http://dimacs.rutgers.edu/~graham/pubs/papers/fwddecay.pdf),” at *25th IEEE International Conference on Data
      Engineering* (ICDE), March 2009.

  1.  Ted Dunning and Otmar Ertl:
      “[Computing Extremely Accurate Quantiles Using t-Digests](https://github.com/tdunning/t-digest),” *github.com*, March 2014.

  1.  Gil Tene:
      “[HdrHistogram](http://www.hdrhistogram.org/),” *hdrhistogram.org*.

  1.  Baron Schwartz:
      “[Why Percentiles Don’t Work the Way You Think](https://orangematter.solarwinds.com/2016/11/18/why-percentiles-dont-work-the-way-you-think/),” *solarwinds.com*, November 18, 2016.

  1.  James Hamilton:
      “[On Designing and Deploying Internet-Scale Services](https://www.usenix.org/legacy/events/lisa07/tech/full_papers/hamilton/hamilton.pdf),” at *21st Large Installation
      System Administration Conference* (LISA), November 2007.

  1.  Brian Foote and Joseph Yoder:
      “[Big Ball of Mud](http://www.laputan.org/pub/foote/mud.pdf),” at
      *4th Conference on Pattern Languages of Programs* (PLoP),
      September 1997.

  1.  Frederick P Brooks: “No Silver Bullet – Essence and
      Accident in Software Engineering,” in *The Mythical Man-Month*, Anniversary
      edition, Addison-Wesley, 1995. ISBN: 978-0-201-83595-3

  1.  Ben Moseley and Peter Marks:
      “[Out of the Tar Pit](http://citeseerx.ist.psu.edu/viewdoc/summary?doi=10.1.1.93.8928),”
      at *BCS Software Practice Advancement* (SPA), 2006.

  1.  Rich Hickey:
      “[Simple Made Easy](http://www.infoq.com/presentations/Simple-Made-Easy),”
      at *Strange Loop*, September 2011.

  1.  Hongyu Pei Breivold, Ivica Crnkovic, and Peter J. Eriksson:
      “[Analyzing Software Evolvability](http://www.es.mdh.se/pdf_publications/1251.pdf),”
      at *32nd Annual IEEE International Computer Software and Applications Conference*
      (COMPSAC), July 2008.
      [doi:10.1109/COMPSAC.2008.50](http://dx.doi.org/10.1109/COMPSAC.2008.50)

</details>


## Ch. 2: Data Models and Query Languages

A conceptual (abstract) model is a representation of a system. It consists of concepts used to help 
people know, understand, or simulate a subject the model represents. In contrast, physical models are 
physical objects, such as a toy model that may be assembled and made to work like the object it represents. 

A data model is an abstract model that organizes elements of data and standardizes how they relate to one 
another and to the properties of real-world entities. For instance, a data model may specify that the data 
element representing a car be composed of a number of other elements which, in turn, represent the color and 
size of the car and define its owner.

A data model instance may be one of three kinds according to ANSI in 1975:
    - Conceptual data model: describes the semantics of a domain, being the scope of the model. For example, it may be a model of the interest area of an organization or industry. This consists of entity classes, representing kinds of things of significance in the domain, and relationship assertions about associations between pairs of entity classes. A conceptual schema specifies the kinds of facts or propositions that can be expressed using the model. In that sense, it defines the allowed expressions in an artificial 'language' with a scope that is limited by the scope of the model.
    - Logical data model: describes the semantics, as represented by a particular data manipulation technology. This consists of descriptions of tables and columns, object oriented classes, and XML tags, among other things.
    - Physical data model: describes the physical means by which data are stored. This is concerned with partitions, CPUs, tablespaces, and the like.

### Relational Model Versus Document Model

Polyglot persistence is a term that refers to using multiple data storage technologies for varying 
data storage needs across an application or within smaller components of an application. Such varying 
data storage needs could arise in both the cases, i.e. an enterprise with multiple applications or singular 
components of an application needing to store data differently. 

Linked in profile page can be excellently presented as JSON.

![Figure 2-2. One-to-many relationships forming a tree structure.](https://i.imgur.com/XXmJaZ1.png)

Even if the initial version of an application fits well in a join-free document model, 
data has a tendency of becoming more interconnected as features are added to applications. 
If the database itself does not support joins, you have to emulate a join in application code by making 
multiple queries to the database. 

![Figure 2-4. Extending résumés with many-to-many relationships.](https://i.imgur.com/CllChxP.png)


Key insight of the relational model was this: you only need to build a query optimizer once, 
and then all applications that use the database can benefit from it. If you don’t have a query 
optimizer, it’s easier to hand code the access paths for a particular query than to 
write a general-purpose optimizer—but the general-purpose solution wins in the long run.

If the data in your application has a document-like structure (i.e., a tree of one-to-many 
relationships, where typically the entire tree is loaded at once), then it’s probably a good idea to 
use a document model. The relational technique of shredding—splitting a document-like structure 
into multiple tables can lead to cumbersome schemas and unnecessarily complicated application code.

- schema-on-read: the  structure  of  the  data  is  implicit,  and  only  interpreted  when  the data is read
- schema-on-write: the traditional approach of relational databases, schema is explicit and the database ensures all written data conforms to it

### Query Languages for Data


### Graph-Like Data Models
A graph consists of two kinds of objects: vertices (also known as nodes or entities) and
edges (also known as relationships or arcs). Many kinds of data can be modeled as a
graph. Typical examples include:
- Social graphs: Vertices are people, and edges indicate which people know each other.
- The web graph: Vertices are web pages, and edges indicate HTML links to other pages.
- Road or rail networks: Vertices are junctions, and edges represent the roads or railway lines between them.

Well-known algorithms can operate on these graphs: for example, car navigation systems search 
for the shortest path between two points in a road network, and PageRank can be used on the web 
graph to determine the popularity of a web page and thus its ranking in search results.

![figure 2-5](https://i.imgur.com/QiXoP64.png)

<details>
  <summary>References</summary>

  1.  Edgar F. Codd:
      “[A Relational Model of Data for Large Shared Data Banks](https://www.seas.upenn.edu/~zives/03f/cis550/codd.pdf),” *Communications of the ACM*, volume 13, number
      6, pages 377–387, June 1970.
      [doi:10.1145/362384.362685](http://dx.doi.org/10.1145/362384.362685)

  1.  Michael Stonebraker and Joseph M. Hellerstein:
      “[What Goes Around Comes Around](http://mitpress2.mit.edu/books/chapters/0262693143chapm1.pdf),”
      in *Readings in Database Systems*, 4th edition, MIT Press, pages 2–41, 2005.
      ISBN: 978-0-262-69314-1

  1.  Pramod J. Sadalage and
      Martin Fowler: *NoSQL Distilled*. Addison-Wesley, August 2012. ISBN:
      978-0-321-82662-6

  1.  Eric Evans:
      “[NoSQL: What's in a Name?](https://web.archive.org/web/20190623045155/http://blog.sym-link.com/2009/10/30/nosql_whats_in_a_name.html),” *blog.sym-link.com*, October 30, 2009.

  1.  James Phillips:
        “[Surprises in Our NoSQL   Adoption Survey](http://blog.couchbase.com/nosql-adoption-survey-surprises),” *blog.couchbase.com*, February 8, 2012.

  1.  Michael Wagner:
        *SQL/XML:2006 – Evaluierung der Standardkonformität ausgewählter Datenbanksysteme*.
        Diplomica Verlag, Hamburg, 2010. ISBN: 978-3-836-64609-3

  1.  “[XML Data (SQL Server)](https://docs.microsoft.com/en-us/sql/relational-databases/xml/xml-data-sql-server?view=sql-server-ver15),” SQL Server documentation, *docs.microsoft.com*, 2013.

  1.  “[PostgreSQL   9.3.1 Documentation](http://www.postgresql.org/docs/9.3/static/index.html),” The PostgreSQL Global Development Group, 2013.

  1.  “[The MongoDB 2.4 Manual](http://docs.mongodb.org/manual/),” MongoDB, Inc., 2013.

  1.  “[RethinkDB 1.11 Documentation](http://www.rethinkdb.com/docs/),” *rethinkdb.com*, 2013.

  1.  “[Apache CouchDB 1.6 Documentation](http://docs.couchdb.org/en/latest/),” *docs.couchdb.org*, 2014.

  1.  Lin Qiao, Kapil Surlaker, Shirshanka Das, et al.:
      “[On Brewing Fresh Espresso: LinkedIn’s Distributed Data Serving Platform](http://www.slideshare.net/amywtang/espresso-20952131),” at *ACM International Conference on Management
      of Data* (SIGMOD), June 2013.

  1.  Rick Long, Mark Harrington, Robert Hain, and Geoff Nicholls:
      [*IMS Primer*](http://www.redbooks.ibm.com/redbooks/pdfs/sg245352.pdf).
      IBM Redbook SG24-5352-00, IBM International Technical Support Organization, January 2000.

  1.  Stephen D. Bartlett:
      “[IBM’s IMS—Myths, Realities, and Opportunities](ftp://public.dhe.ibm.com/software/data/ims/pdf/TCG2013015LI.pdf),” The Clipper Group Navigator, TCG2013015LI, July 2013.

  1.  Sarah Mei:
      “[Why You Should Never Use MongoDB](http://www.sarahmei.com/blog/2013/11/11/why-you-should-never-use-mongodb/),”
      *sarahmei.com*, November 11, 2013.

  1.  J. S. Knowles and D. M. R. Bell:
      “The CODASYL Model,” in *Databases—Role and Structure: An Advanced Course*, edited by P. M.
      Stocker, P. M. D. Gray, and M. P. Atkinson, pages 19–56, Cambridge University Press, 1984. ISBN:
      978-0-521-25430-4

  1.  Charles W. Bachman:
      “[The Programmer as Navigator](http://dl.acm.org/citation.cfm?id=362534),”
      *Communications of the ACM*, volume 16, number 11, pages 653–658, November 1973.
      [doi:10.1145/355611.362534](http://dx.doi.org/10.1145/355611.362534)

  1.  Joseph M. Hellerstein, Michael Stonebraker, and James Hamilton:
      “[Architecture of a Database System](http://db.cs.berkeley.edu/papers/fntdb07-architecture.pdf),”
      *Foundations and Trends in Databases*, volume 1, number 2, pages 141–259, November 2007.
      [doi:10.1561/1900000002](http://dx.doi.org/10.1561/1900000002)

  1.  Sandeep Parikh and Kelly Stirman:
      “[Schema Design for Time Series Data in MongoDB](http://blog.mongodb.org/post/65517193370/schema-design-for-time-series-data-in-mongodb),” *blog.mongodb.org*, October 30, 2013.

  1.  Martin Fowler:
      “[Schemaless Data Structures](http://martinfowler.com/articles/schemaless/),”
      *martinfowler.com*, January 7, 2013.

  1.  Amr Awadallah:
      “[Schema-on-Read vs. Schema-on-Write](http://www.slideshare.net/awadallah/schemaonread-vs-schemaonwrite),” at *Berkeley EECS RAD Lab Retreat*, Santa Cruz, CA, May 2009.

  1.  Martin Odersky:
      “[The Trouble with Types](http://www.infoq.com/presentations/data-types-issues),”
      at *Strange Loop*, September 2013.

  1.  Conrad Irwin:
      “[MongoDB—Confessions of a PostgreSQL Lover](https://speakerdeck.com/conradirwin/mongodb-confessions-of-a-postgresql-lover),” at *HTML5DevConf*, October 2013.

  1.  “[Percona Toolkit Documentation: pt-online-schema-change](http://www.percona.com/doc/percona-toolkit/2.2/pt-online-schema-change.html),” Percona Ireland Ltd., 2013.

  1.  Rany Keddo, Tobias Bielohlawek, and Tobias Schmidt:
      “[Large Hadron Migrator](https://github.com/soundcloud/lhm),” SoundCloud, 2013.

  1.  Shlomi Noach:
      “[gh-ost: GitHub's Online Schema Migration Tool for MySQL](http://githubengineering.com/gh-ost-github-s-online-migration-tool-for-mysql/),” *githubengineering.com*, August 1, 2016.

  1.  James C. Corbett, Jeffrey Dean, Michael Epstein, et al.:
      “[Spanner: Google’s Globally-Distributed Database](https://research.google/pubs/pub39966/),”
      at *10th USENIX Symposium on Operating System Design and Implementation* (OSDI),
      October 2012.

  1.  Donald K. Burleson:
      “[Reduce I/O with Oracle Cluster Tables](http://www.dba-oracle.com/oracle_tip_hash_index_cluster_table.htm),” *dba-oracle.com*.

  1.  Fay Chang, Jeffrey Dean, Sanjay Ghemawat, et al.:
      “[Bigtable: A Distributed Storage System for Structured Data](https://research.google/pubs/pub27898/),” at *7th USENIX Symposium on Operating System Design and
      Implementation* (OSDI), November 2006.

  1.  Bobbie J. Cochrane and Kathy A. McKnight:
      “[DB2 JSON Capabilities, Part 1: Introduction to DB2 JSON](http://www.ibm.com/developerworks/data/library/techarticle/dm-1306nosqlforjson1/),” IBM developerWorks, June 20, 2013.

  1.  Herb Sutter:
      “[The Free Lunch Is Over: A Fundamental Turn Toward Concurrency in Software](http://www.gotw.ca/publications/concurrency-ddj.htm),” *Dr. Dobb's Journal*,
      volume 30, number 3, pages 202-210, March 2005.

  1.  Joseph M. Hellerstein:
      “[The Declarative Imperative: Experiences and Conjectures in Distributed Logic](http://www.eecs.berkeley.edu/Pubs/TechRpts/2010/EECS-2010-90.pdf),” Electrical Engineering and
      Computer Sciences, University of California at Berkeley, Tech report UCB/EECS-2010-90, June
      2010.

  1.  Jeffrey Dean and Sanjay Ghemawat:
      “[MapReduce: Simplified Data Processing on Large Clusters](https://research.google/pubs/pub62/),” at *6th USENIX Symposium on Operating System Design and
      Implementation* (OSDI), December 2004.

  1.  Craig Kerstiens:
      “[JavaScript in Your Postgres](https://blog.heroku.com/javascript_in_your_postgres),”
      *blog.heroku.com*, June 5, 2013.

  1.  Nathan Bronson, Zach Amsden, George Cabrera, et al.:
      “[TAO: Facebook’s Distributed Data Store for the Social Graph](https://www.usenix.org/conference/atc13/technical-sessions/presentation/bronson),” at
      *USENIX Annual Technical Conference* (USENIX ATC), June 2013.

  1.  “[Apache TinkerPop3.2.3 Documentation](http://tinkerpop.apache.org/docs/3.2.3/reference/),” *tinkerpop.apache.org*, October 2016.

  1.  “[The Neo4j Manual v2.0.0](http://docs.neo4j.org/chunked/2.0.0/index.html),”
      Neo Technology, 2013.

  1.  Emil Eifrem:
      [Twitter correspondence](https://twitter.com/emileifrem/status/419107961512804352), January 3, 2014.

  1.  David Beckett and Tim Berners-Lee:
      “[Turtle – Terse RDF Triple Language](http://www.w3.org/TeamSubmission/turtle/),”
      W3C Team Submission, March 28, 2011.

  1.  “[Datomic Development Resources](http://docs.datomic.com/),” Metadata Partners, LLC, 2013.

  1.  W3C RDF Working Group:
      “[Resource Description Framework (RDF)](http://www.w3.org/RDF/),”
      *w3.org*, 10 February 2004.

  1.  “[Apache Jena](http://jena.apache.org/),”
      Apache Software Foundation.

  1.  Steve Harris, Andy Seaborne, and Eric
      Prud'hommeaux: “[SPARQL 1.1 Query Language](http://www.w3.org/TR/sparql11-query/),”
      W3C Recommendation, March 2013.

  1.  Todd J. Green, Shan Shan Huang, Boon Thau Loo, and Wenchao Zhou:
      “[Datalog and Recursive Query Processing](http://blogs.evergreen.edu/sosw/files/2014/04/Green-Vol5-DBS-017.pdf),” *Foundations and Trends in Databases*,
      volume 5, number 2, pages 105–195, November 2013.
      [doi:10.1561/1900000017](http://dx.doi.org/10.1561/1900000017)

  1.  Stefano Ceri, Georg Gottlob, and Letizia Tanca:
      “[What You Always Wanted to Know About Datalog (And Never Dared to Ask)](https://www.researchgate.net/profile/Letizia_Tanca/publication/3296132_What_you_always_wanted_to_know_about_Datalog_and_never_dared_to_ask/links/0fcfd50ca2d20473ca000000.pdf),” *IEEE
      Transactions on Knowledge and Data Engineering*, volume 1, number 1, pages 146–166, March 1989.
      [doi:10.1109/69.43410](http://dx.doi.org/10.1109/69.43410)

  1.  Serge Abiteboul, Richard Hull, and Victor Vianu:
      [*Foundations of Databases*](http://webdam.inria.fr/Alice/). Addison-Wesley, 1995.
      ISBN: 978-0-201-53771-0, available online at *webdam.inria.fr/Alice*

  1.  Nathan Marz:
      “[Cascalog](https://github.com/nathanmarz/cascalog)," *github.com*.

  1.  Dennis A. Benson,
        Ilene Karsch-Mizrachi, David J. Lipman, et al.:
        “[GenBank](https://academic.oup.com/nar/article/36/suppl_1/D25/2507746),”
        *Nucleic Acids Research*, volume 36, Database issue, pages D25–D30, December 2007.
        [doi:10.1093/nar/gkm929](http://dx.doi.org/10.1093/nar/gkm929)

  1.  Fons Rademakers:
        “[ROOT for Big Data Analysis](https://indico.cern.ch/event/246453/contributions/1566610/attachments/423154/587535/ROOT-BigData-Analysis-London-2013.pdf),” at *Workshop on the Future of Big Data Management*,
        London, UK, June 2013.

</details>