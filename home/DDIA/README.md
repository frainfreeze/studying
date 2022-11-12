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

