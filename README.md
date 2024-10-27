# Agentic Data Access benchmark (ADA benchmark)

Agentic Data Access benchmark is a set of real-world questions over few "closed domains" to illustrate the evaluation of closed domain AI assistants/agents.
Closed domains are domains where data is not available implicitly in the LLM as they reside in secure or private systems e.g. enterprise databases, SaaS applications, etc
and AI solutions require mechanisms to connect an LLM to such data. If you are evaluating an AI product or building your own AI architecture over closed domains, then you can use 
these questions/nature of questions to understand the capabilities of your system and qualitatively measure the performance of your assistants/agents.

ADA benchmark was created because of severe short-comings found in closed domain assistants in the wild. We found that apart from few basic canned questions or workflows,
the assistants were struggling to do anything new. This was found to be because the assistant is not connected 
to sufficient data and is unable to perform complex or sequential operations over that data. We call the ability of an AI system, given the description of data, to agentically use and operate on that data as agentic data access.

TODO: Add input/output diagram

## About the questions

The question set is hosted here: https://huggingface.co/datasets/hasura/agentic-data-access-benchmark

Preview:

| Prompt | Domain | Data requirements | Data complexity level | Agentic complexity notes |
|--------|---------|-------------------|---------------------|------------------|
| Show me unread emails from the past week which are important or need follow-up. | Email + Calendar | 1. Get Emails in time range 2. Get Email Metadata | High | Following connections, Compute |
| Get all receipts from food orders this week | Email + Calendar | 1. Get Emails in time range 2. Get attachments | High | Following connections, Compute |
| Summarize my upcoming travel itinerary with flight numbers, hotels, car rentals, etc | Email + Calendar | 1. Get Emails | High | Smart search strategy, Compute |
| Are there any customers on paid plan who have created support tickets in the last 7 days | Customer Support | 1. Get Tickets of last 7 days with the `email` of the submitter<br>2. Get Users for those emails<br>3. Get Projects with Plans for those users | Medium | Following connections |
| Are there any support tickets that have not been responded to in the last 30 days | Customer Support | 1. Get Tickets and Ticket Comments of last 30 days | Medium | Large context/Smart search strategy |
| Which users are at risk of churn, look at project usage, support tickets, etc? | Customer Support | 1. Get Tickets from ~90 days ago<br>2. Get Projects where Usage is low or zero<br>3. Get Projects where Errors are high | High | Large context, Following connections, Compute |
| Help me prioritize support ticket #1234 amongst other open tickets based on user's plan, revenue and usage | Customer Support | 1. Get all Tickets with `status=open`<br>2. Get Project from project_name or submitter email<br>3. Get Plan from Project<br>4. Get Invoices from project<br>5. Get Usage from Project | High | Smart search strategy, Following connections |

We use a select set of common domains as a guiding "north star" to illustrate the what an AI assistant/agent could be capable of achieving.
These domains are Customer Support, Email+Calendar, Sales, HR, Engineering Management and described in brief [here](./domains/domain-descriptions.md).

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

## Use-case categories

Below we describe fundamental use-cases which are common across all domains: 

### Multi-step data retrieval

This use-case involves fetching data from multiple locations e.g. fetching data from different tables in a database, getting data from different databases, etc
It is possible that the data from one step is used in the next step (composition) as well.

*Example question (Customer Support):*  Get the projects, invoices, project usage for the user wile@acme.corp 


### Data aggregation

This use-case involves aggregating data from simpler data points e.g. counting, summing, grouping on list of items.
Note that for AI assistants, most of the aggregations would be for adhoc analysis where existing dashboards may not suffice or require non-trivial work. 

*Example question (HR):* What is the average hours count and dollar amount of PTO paid out to departing team members?

### Bulk insights

This use-case involves going to each data item and creating specific insights for each one of them

*Example question (Customer Support):* For all tickets open for more than a week, tell me what they are blocked on?

### Bulk classification

This use-case involves finding relevant items over bulk data by classifying/categorizing them as relevant or not.
Usually the classification is based on textual input rather than structured attributes.

*Example question (Email):* Get all receipts from food orders this month


### Point search

This use-case involves finding the most relevant item(s) with complex characteristics over bulk data.

*Example question (Email):* Find me the email from Wile where I spoke about business strategy

### Structured information extraction

This use-case involves extracting information from textual data in a structured format so it can be fed to other systems.

*Example question (Sales):*  Create a new opportunity for Acme corp from recent call transcripts, fill in Opportunity Name, Segment, Product SKU, ARR and Next Steps


### Data visualization

This use-case essentially involves visualizing or transforming data in a way where it is more easily consumable for a human.

*Example question (Email):* How have I spent my time on meetings this month?


## What's next

We are providing raw data for these domains in the `domains` folder (Note: we are starting with Customer Support first). 
You can evaluate the capabilities of your AI assistant by incorporating this data into your architecture and trying it with your LLMs.

We, at Hasura, have built PromptQL for agentic data access needs. Go to hasura.io/promptql to learn more. 
