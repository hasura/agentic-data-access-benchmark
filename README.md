# Introducing the Data Access Agent Benchmark

An open problem in enterprise AI deployment is building systems that can effectively access, process, and reason over private organizational data. While language models have shown impressive capabilities with public knowledge, their ability to work with private enterprise data remains limited. Most enterprise AI assistants today can only handle basic predefined workflows and struggle with novel requests or complex data operations.

To address this challenge and measure the effectiveness of AI systems in enterprise settings, we are releasing the Data Access Agent Benchmark (DAAB), a comprehensive evaluation framework for assessing AI systems' ability to work with private enterprise data.

## Prior Art and Motivation

### Evolution of LLM Benchmarks

The landscape of AI benchmarks has evolved significantly over the past decade. Early benchmarks like SQuAD[^1], TriviaQA[^2], and NaturalQuestions[^3] focused primarily on evaluating question-answering capabilities over public information (typically using Wikipedia as source of truth). For database question-answering, specialized datasets like Spider[^4], WikiSQL[^5], and BIRD[^6] have emerged to evaluate a language model's ability to translate natural language queries into SQL statements (text-to-SQL).
. With the emergence of Large Language Models (LLMs), these traditional benchmarks have been largely surpassed. More recent evaluations like MMLU[^7] and Big-Bench Hard[^8] have shifted focus to assess broader reasoning and language understanding capabilities more appropriate for modern LLMs. There is still significant energy in both academia and industry in creating good datasets for benchmarking different LLM capabilities as seen by OpenAI's SimpleQA[^9] benchmark.

### Benchmarks for LLMs with External Systems

While traditional benchmarks evaluate AI capabilities using knowledge embedded within model parameters, a new class of benchmarks has emerged to assess LLM performance when interfacing with external systems. These generally fall into two categories:

1. Retrieval-augmented approaches[^10],[^11]: This incorporates explicit retrieval steps to enhance the user input with external data. Classic benchmarks like TriviaQA[^2] and NaturalQuestions[^3] have been adapted for retrieval-augmentation using text embedding methods (like S-BERT[^12]). Benchmarks like HotPotQA are used for evaluating multi-hop retrieval strategies. like FRAMES[^13] and CRAG[^14] enhance the complexity of the questions and make it more real-world.

2. Tool use[^25], [^30]: Tool use enables LLMs to dynamically request and interact with external tools - from simple calculators to complex APIs and web search capabilities. This is a more recent advancement and various benchmarks like ToolQA[^26], API-bank[^27] and HotPotQA[^31] are used for evaluating tool use capability of the LLM. More recently, tool use has enabled diverse efforts in making more agentic systems and generic assistants as evident from benchmarks like GAIA[^32].

### Limitations for Enterprise Applications

Current benchmarks face several critical limitations when applied to enterprise settings:

1. Data Privacy Context: Existing benchmarks predominantly focus on public knowledge. While they incorporate retrieval and tool use, they fail to capture the unique challenges of private organizational data. Enterprise environments typically involve sensitive, proprietary information

2. Data Source Complexity: Traditional benchmarks evaluate performance on single sources or databases. Enterprise data typically spans multiple systems and formats. Integration challenges are often overlooked in current evaluations

3. Task Authenticity: Most benchmarks rely on synthetic or academic tasks. Even advanced datasets like GAIA[^32] fail to capture typical enterprise queries. Real business questions often involve different complexity patterns

4. Data Dynamism: Existing benchmarks typically use static datasets. Enterprise systems must handle dynamic, continuously updating data sources. Real-time data processing requirements are rarely addressed

5. Full System Evaluation: While numerous benchmarks exist for evaluating individual components of AI systems, comprehensive end-to-end evaluation remains a challenge. Most benchmarks focus on isolated capabilities like retrieval or reasoning, rather than assessing how these components work together in production environments. This challenge is particularly acute in enterprise settings, where data sprawl, heterogenous data storage, custom organization is very common

These limitations underscore the need for new benchmark frameworks specifically designed to evaluate AI systems' effectiveness in enterprise contexts, with particular attention to real-world data complexity, privacy requirements, and task complexity.

### Related Technical Approaches and their Limitations

We will briefly overview few common approaches to build systems on enterprise data and discuss their limitations.

1. **Retrieval Augmented Generation (RAG)**
   - Retrieval-augmented methods [^33] have been used to search for relevant documents and used as additional input context for generating answers from external systems.
   - Early work by ReaLM and Lewis et al.[^14] introduced RAG.
   - Primarily uses text embeddings as a search mechanism
   - Embeddings suffer from lack of temporality, attribute based filtering, and loss of user-context authorization 
   - Not all data is text. Structured data in databases, etc

2. **Database Question Answering**
   - Text-to-SQL systems can be used to retrieve data from SQL databases. Recent advances in semantic parsing for database queries[^21]
   - Challenges in complex joins and nested queries[^22]
   - Enterprise Data is spread in multiple databases
   - Not all data is structured.
   - Need to perform tasks like summarize, classify, cluster, point search, etc for which SQL is not apt
  
3. **Tool use in LLMs**
   - Tool use can be used to agentically retrieve and perform tasks
   - Most generic method
   - All APIs don't exist
   - APIs are not well documented
   - Composing tools with large data inputs prone to hallucination


## About the Data Access Agent Benchmark

The ability of an AI system to autonomously access and operate on enterprise data - what we call "agentic data access" - is crucial for building truly useful enterprise AI solutions. DAAB is designed to evaluate complete AI systems, which may include multiple models, tools, and retrieval pipelines, rather than focusing on individual models in isolation.

With DAAB, our goal was to create a benchmark with the following properties:

- **Real-world relevance**: Questions are derived from actual enterprise use cases across common domains like Customer Support, Email+Calendar, Sales, and HR.
- **Comprehensive evaluation**: The benchmark tests various complexity levels of data access and computation, from simple retrieval to complex multi-step operations.
- **System-agnostic**: The benchmark can evaluate any AI system architecture, whether it uses a single large model or multiple specialized components.
- **Practical applicability**: Questions reflect tasks that enterprise users actually need help with, making the benchmark results directly relevant to real-world applications.

## Benchmark Structure

DAAB contains approximately 150 questions across different enterprise domains. Each question is categorized along multiple dimensions:

1. **Domain**: The business function the question relates to (e.g., Customer Support, Email+Calendar)
2. **Data Requirements**: What data needs to be accessed to answer the question
3. **Agentic Complexity Level**: Rated as Low, Medium, or High
4. **Agentic Complexity Notes**: Specific aspects that make the question challenging

### Use Case Categories

The benchmark identifies several fundamental use-case categories that are common across domains:

1. **Multi-step Data Retrieval**: Tasks requiring data fetching from multiple sources
2. **Data Aggregation**: Computing summaries or statistics from raw data
3. **Bulk Insights**: Analyzing multiple data items to extract specific insights
4. **Bulk Classification**: Finding relevant items using textual classification
5. **Clustering**: Identifying similar properties in bulk data
6. **Point Search**: Finding specific items with complex characteristics
7. **Structured Information Extraction**: Converting unstructured text to structured data
8. **Data Visualization**: Transforming data into human-friendly formats
9. **Needle in a haystack**: Searching for all relevant data snippets from a query string

## Question Distribution

TODO: Add a pie chart showing the distribution of questions across different dimensions (domains, complexity levels, use case categories)

## Example Questions and Systems

Here are some example questions from the benchmark that illustrate different complexity levels:

**High Complexity**:
```
"Help me prioritize support ticket #1234 amongst other open tickets based on user's plan, revenue and usage"

Data Requirements:
1. Get all Tickets with status=open
2. Get Project from project_name or submitter email
3. Get Plan from Project
4. Get Invoices from project
5. Get Usage from Project
```

**Medium Complexity**:
```
"Are there any support tickets that have not been responded to in the last 30 days"

Data Requirements:
1. Get Tickets and Ticket Comments of last 30 days
```

TODO: Add example system architectures and how they approach these questions


## Evaluation Methodology

The Data Access Agent Benchmark employs a multi-dimensional evaluation framework to assess system performance across different aspects of data access and computation.

### Core Metrics

1. **Human Directed Task Completion Rate**
   - Binary success/failure for each task
  
2. **Task-Oriented Dialogue Systems**
   - Traditional frameworks like MultiWOZ[^17] established patterns for goal-oriented interactions
   - Recent work by Hosseini-Asl et al.[^18] on multi-domain dialogue state tracking
   - Enterprise applications by Ham et al.[^19] showing challenges in real-world deployments
   - ACUTE-EVAL: Improved dialogue evaluation with optimized questions and
multi-turn comparisons[^28]

## Building on Previous Work

The Data Access Agent Benchmark builds upon and extends previous work in several key ways:

1. **Enhanced Evaluation Framework**: Drawing from the structured evaluation approaches of benchmarks like HELM[^9] and OpenAI Evals[^10], DAAB adds enterprise-specific metrics and evaluation criteria.

2. **Real-world Task Design**: Inspired by the task complexity framework from BabyAI[^11], we've designed tasks that reflect actual enterprise workflows rather than synthetic challenges.

3. **System-level Assessment**: Building on agent evaluation frameworks like AgentBench[^5], we extend the evaluation to cover complete enterprise AI systems rather than individual components.

4. **Data Access Patterns**: Incorporating insights from database QA systems[^12] and enterprise search evaluations[^13], we've developed comprehensive patterns for assessing data access capabilities.

## Conclusion

The Data Access Agent Benchmark represents a significant step forward in evaluating enterprise AI systems' ability to work with private data. By providing a standardized way to assess these capabilities, we hope to drive progress in building more effective enterprise AI solutions that can truly understand and work with organizational data.

The complete benchmark dataset is available at [TODO: Add link to dataset].

We invite the AI community to use this benchmark in evaluating their enterprise AI systems and welcome feedback on making it even more useful for measuring progress in this crucial area.

## References

[^1]: Rajpurkar et al. (2016). SQuAD: 100,000+ Questions for Machine Comprehension of Text
[^2]: Joshi et al. (2017). TriviaQA: A Large Scale Distantly Supervised Challenge Dataset for Reading Comprehension
[^3]: https://research.google/pubs/natural-questions-a-benchmark-for-question-answering-research/
[^4]: Spider: A Large-Scale Human-Labeled Dataset for Complex and Cross-Domain Semantic Parsing and Text-to-SQL Task
[^5]: https://huggingface.co/datasets/Salesforce/wikisql
[^6]: A BIg Bench for Large-Scale Database Grounded Text-to-SQLs
[^7]: Hendrycks et al. (2020). Measuring Massive Multitask Language Understanding
[^8]: Challenging BIG-Bench Tasks and Whether Chain-of-Thought Can Solve Them
[^9]: https://openai.com/index/introducing-simpleqa/
[^10]: REALM: Retrieval-Augmented Language Model Pre-Training
[^11]: Lewis et al. (2020). Retrieval-Augmented Generation for Knowledge-Intensive NLP Tasks
[^12]: Sentence-BERT: Sentence Embeddings using Siamese BERT-Networks
[^13]: FRAMES: Fact, Fetch, and Reason: A Unified Evaluation of Retrieval-Augmented Generation
[^14]: Comprehensive RAG Benchmark
[^4]: Srivastava et al. (2022). Beyond the Imitation Game: Quantifying and extrapolating the capabilities of language models
[^5]: Liu et al. (2023). AgentBench: Evaluating LLMs as Agents
[^6]: Wei et al. (2024). SimpleQA: A Factuality Benchmark for Language Models
[^7]: LangChain Documentation (2023)
[^8]: AutoGPT Documentation (2023)
[^9]: Liang et al. (2022). Holistic Evaluation of Language Models
[^10]: OpenAI Evals Documentation (2023)
[^11]: Chevalier-Boisvert et al. (2018). BabyAI: First Steps Towards Grounded Language Learning With a Human In the Loop
[^12]: Li et al. (2023). Text-to-SQL: State of the Art and Future Directions
[^13]: Zhang et al. (2022). Enterprise Search in the Era of Large Language Models
[^15]: Chen et al. (2022). Enterprise RAG: Improving Business Document Retrieval with Large Language Models
[^16]: Shi et al. (2023). A Survey of Retrieval-Augmented Text Generation
[^17]: Budzianowski et al. (2018). MultiWOZ - A Large-Scale Multi-Domain Wizard-of-Oz Dataset for Task-Oriented Dialogue Modelling
[^18]: Hosseini-Asl et al. (2020). A Simple Language Model for Task-Oriented Dialogue
[^19]: Ham et al. (2023). Challenges in Deploying Task-Oriented Dialogue Systems in Enterprise Settings
[^20]: Yu et al. (2018). Spider: A Large-Scale Human-Labeled Dataset for Complex and Cross-Domain Semantic Parsing and Text-to-SQL Task
[^21]: Wang et al. (2023). Semantic Parsing in Enterprise: Current Status and Future Directions
[^22]: Li et al. (2023). Complex Query Construction for Modern Database Question Answering Systems
[^24]: MultiHop-RAG: Benchmarking Retrieval-Augmented Generation for Multi-Hop Queries
[^25]: Toolformer: Language Models Can Teach Themselves to Use Tools
[^26]: ToolQA: A Dataset for LLM Question Answering with External Tools
[^27]: API-Bank: A Comprehensive Benchmark for Tool-Augmented LLMs
[^28]: ACUTE-EVAL: Improved Dialogue Evaluation with Optimized Questions and Multi-turn Comparisons
[^29]: Augmented Language Models: a Survey https://arxiv.org/pdf/2302.07842
[^30]: ReAct: Synergizing Reasoning and Acting in Language Models
[^31]: HotpotQA: A Dataset for Diverse, Explainable Multi-hop Question Answering
[^32]: GAIA: A Benchmark for General AI Assistants
[^33]: Retrieval-Augmented Generation for AI-Generated Content: A Survey




