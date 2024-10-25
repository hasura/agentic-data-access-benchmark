# Agentic Data Access benchmark (ADA benchmark)

Agentic Data Access benchmark is a set of real-world questions over few "closed domains" which can benefit tremendously from AI assistants/agents.
Closed domains are domains where data is not available implicitly in the LLM as they reside in secure or private systems e.g. enterprise databases.
If you are evaluating an AI product or building your own assistant over closed domains, then you can use the nature of questions here to qualitatively measure 
the capabilities of your assistants/agents.

ADA benchmark was created because of severe short-comings found in closed-domain assistants in the wild. We found that apart from few basic canned questions or workflows,
the assistants were struggling to do anything new. This was found to be because the assistant is not connected 
to sufficient data and is unable to perform complex or sequential operations over that data. We call the ability of an AI system to agentically use and operate on data as agentic data access.

## About the questions

The question set is hosted here: https://huggingface.co/datasets/hasura/agentic-data-access-benchmark

We use a select set of common domains as a guiding "north star" to illustrate the long-term vision for what an AI assistant/agent should be capable of achieving.
These domains are described below in brief.

### Customer Support

This domain is for an API SaaS (Software as a Service) company's customer success/support department. The focus is on understanding customer behavior, addressing issues proactively, and maintaining strong relationships with business customers who are using the company's software. The stakeholders in this domain can range from support staff to customer relationship managers.

### Email + Calendar

This domain is like a Digital Personal Assistant, specifically focused on email and calendar management. The tasks involve scheduling and managing calendar events, searching and information extraction through emails for specific types of content (receipts, travel documents, statements), and organizing personal business information. 

### Sales

This domain represents Sales Operations. The system tracks sales pipelines, opportunity stages, customer communications (emails and calls), account ownership, sales cycle analytics, and renewal management. The core purpose is to help sales teams track their deals, manage customer relationships effectively, monitor sales performance metrics, stay on top of their follow-up tasks and providing insights into sales efficiency and pipeline health.

### HR

This domain represents HR Information Systems (HRIS), focusing on employee data, benefits administration, compensation, performance management, and time-off tracking. The core purpose is to help HR teams understand workforce trends, track benefit costs and utilization, monitor employee performance and engagement, and make decisions about HR policies and programs.

### Engineering Management

This domain represents Engineering Management, focusing on tracking and managing the software development lifecycle. The core purpose is to help engineering managers understand team performance, code review patterns, issue backlogs, and the relationship between customer requests and development priorities to ensure efficient delivery and quality of software products.

### Overall statistics

In total we have 138 questions, the high level breakdown of the question on different dimensions is visualized below.

<table>
  <tr>
    <td><img src="./query_distribution_by_domain.png" alt="Question distribution by domain" width="400"></td>
    <td><img src="./query_complexity_distribution.png" alt="Question distribution by complexity" width="400"></td>
  </tr>
  <tr>
    <td><img src="./complexity_distribution_by_domain.png" alt="Complexity distribution by domain" width="400"></td>
    <td><img src="./distribution_complexity_factors.png" alt="Distribution of complexity factors" width="400"></td>
  </tr>
  <td><img src="./common_complexity_factor_combinations.png" alt="Common complexity combinations" width="400"></td>
</table>

## Analyzing sample questions

Let's look at few sample questions and analyze qualitatively what it would take to make it work effectively.

**Q1:** (CS domain) *Are there any customers on paid plans who have created support tickets in the last 7 days*

This question requires fetching support tickets in the last 7 days, getting the id or email or project of the ticket submitter, geting their corresponding projects, checking if the plan is paid for those projects. There are various complexities in performing the aforementioned procedure, for instance, the number of support tickets could be quite high (few thousands for a large company) causing large context problems, extracting identifying information from a ticket can be tricky because it could have been created through different channels (direct ticketing, email, phone number, etc) with different kind ofidentifying information. Getting corresponding projects can have absolutely no mistakes - because it is business critical. Lastly, there could be multiple SKUs for a "paid" plan.

**Q2:** (Email domain) *Summarize my upcoming business travel itinerary with flight numbers, hotels, car rentals, etc*

This question requires searching through recent emails to look for travel related bookings. It also may be required to extract necessary information from attachments in those emails.
There are various complexities in performing this task well: we do not know how many emails in the past to look at, there may be more than one business travel in the future hence grouping related business travel together is very important, information should be extracted from attachements and most importantly, there should not be any wrong information (missing information is still fine).

**Q3:** (Sales domain) *Look at recent activities on Acme Corp opportunity and list follow-up tasks from the activity notes*

This question requires finding the right opportunity, looking at the detailed summary/notes in the activities for that opportunity or fetching the corresponding call transcripts/email threads. The main complexity here is understanding implicit relationships in data i.e. activity -> email/call transcript and traversing such implicit relationships effectively.

**Q4:** (HR domain) *What is the average hours count and dollar amount of PTO paid out to departing team members last year?*

This question requires performing a complex calculation over a highly interconnected data model. This is a business critical query and hence there can be no mistakes. For example, it must be ensured that team members used in the calculations are exactly the ones leaving last year, currency should be converted appropriately, ideally actual pay documents with PTO payment should be extracted as well for references.

**Q5:** (Engineering domain) *Suggest a reviewer for PR 1234 by seeing who has contributed the most to the files that have changed in the PR and previous commiters*

To give a good answer here requires making a few intelligent decisions e.g. look for recent contributors instead of lifetime contributors, suggest reviewers who are currently in the org (and not departed employees), look for contributors in the specific team of the PR creator, etc. 


## What's next

TODO
