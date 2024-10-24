# Agentic Data Access benchmark (ADA benchmark)

Agentic Data Access benchmark is a set of real-world questions over few "closed domains" which can benefit tremendously from AI assistants/agents.
Closed domains are domains where data is not available implicitly in the LLM as they reside in secure or private systems e.g. enterprise databases.
If you are evaluating an AI product or building your own assistant over closed domains, then you can use these questions to qualitatively measure the capabilities of your assistants/agents.

ADA benchmark was created because of severe short-comings found in closed-domain assistants in the wild. We found that apart from few basic canned questions or workflows,
the assistants were struggling to do anything new. This was found to be because the assistant is not connected 
to sufficient data and is unable to perform complex or sequential operations over that data. We call the ability of an AI system to agentically use and operate data as agentic data access.


## About the questions

The question set is hosted here: https://huggingface.co/datasets/hasura/agentic-data-access-benchmark

We use a couple of domains to show what data access and operations are required from a decently powerful AI assistant. We will describe them below.

### Customer Support

TODO

### Email + Calendar

TODO

### Sales

TODO

### HR

TODO

### Engineering Management

TODO

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
