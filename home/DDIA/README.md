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

