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

TODO


## What's next

TODO
