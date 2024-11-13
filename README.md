# Introducing the Data Access Agent Benchmark

An open problem in enterprise AI deployment is building systems that can effectively access, process, and reason over private organizational data. While language models have shown impressive capabilities with public knowledge, their ability to work with private enterprise data remains limited. Most enterprise AI assistants today can only handle basic predefined workflows and struggle with novel requests or complex data operations.

To address this challenge and measure the effectiveness of AI systems in enterprise settings, we are releasing the Data Access Agent Benchmark (DAAB), a comprehensive evaluation framework for assessing AI systems' ability to work with private enterprise data.

## Prior Art and Motivation

### Evolution of LLM Benchmarks

The landscape of AI benchmarks has evolved significantly over the last few years. Early benchmarks like SQuAD[^1], TriviaQA[^2], and NaturalQuestions[^3] focused primarily on evaluating question-answering capabilities over public information (typically using Wikipedia as source of truth). For database question-answering, specialized datasets like Spider[^4], WikiSQL[^5], and BIRD[^6] have emerged to evaluate a language model's ability to translate natural language queries into SQL statements (text-to-SQL). With the emergence of Large Language Models (LLMs), these traditional benchmarks have been largely surpassed. Recent evaluations like MMLU[^7], AGIEval[^35], Big-Bench (Hard)[^34],[^8] have ramped up efforts to assess broader reasoning and language understanding capabilities more appropriate for modern LLMs. There is still significant energy in both academia and industry in crafting representative datasets for benchmarking different LLM capabilities as seen most recently by OpenAI's SimpleQA[^9] benchmark.

### Benchmarks for LLMs with External Systems

While traditional benchmarks evaluate LLM capabilities relying on the implicit knowledge embedded within model parameters, a new set of benchmarks has emerged to assess LLM performance when augmented with external systems. Such augmentation is necessary when responses need to be grounded[^44] in facts that are present in these external systems. Though fine-tuning LLMs[^45] with additional data represents one augmentation approach, practical considerations like training costs, keeping models up-to-date, and security considerations have limited its industry adoption. Instead, current industry practices primarily fall into two categories:

1. **Retrieval-augmented approaches**[^10],[^11],[^36]: This approach incorporates explicit retrieval steps of relevant data from a large database and provided alongside the user input. Most classic benchmarks like TriviaQA[^2] and NaturalQuestions[^3] have been used for evaluating retrieval-augmented techniques by using a Wikipedia database. There are various benchmarks like MTEB[^37] which measure the capabilities of text embedding models (like S-BERT[^12]) typically used in the retrieval phase. More complex benchmarks like HotPotQA[^31] (for multi-hop questions) and FEVER[^38] (for fact verification) enhance the task complexity for LLMs and illustrate the need to use retrieval-augmented approaches. More recently, benchmarks like FRAMES[^13] and CRAG[^14] have emerged to make the questions in the dataset more real-world.

2. **Tool use**[^25], [^30]: Tool use enables LLMs to dynamically request and interact with external tools - from simple calculators to data APIs and web search capabilities. To measure the efficiency of an LLM to use tools correctly, benchmarks like ToolQA[^26], API-bank[^27], API-bench[^40] and ToolBench[^39] are used for evaluating tool use capability of the LLM. More recently, tool use for real-world use-cases like generic assistance has paved the way for benchmarks like GAIA[^32].

### Limitations for Enterprise Applications

Current benchmarks face several limitations when applied to enterprise settings:

1. **Data Privacy Context**: Existing benchmarks predominantly focus on public knowledge. While they can incorporate retrieval and tool use, they fail to capture the unique challenges of private organizational data. Enterprise environments typically involve sensitive, proprietary information based on dynamic security rules.

2. **Data Source Complexity**: Traditional benchmarks evaluate performance on a single source of data or database. Enterprise data typically spans multiple systems and formats. Integration challenges are often overlooked in current evaluations

3. **Task Authenticity**: Most benchmarks rely on synthetic or academic tasks (factual question-answering on wikipedia like data being most common). Even advanced datasets like GAIA[^32] fail to capture typical business queries. Real business questions often involve a combination of information retrieval, exploration and decision making.

4. **Data Dynamism**: Existing benchmarks typically use static datasets. Enterprise systems must handle dynamic, continuously updating data sources. 

5. **User-goal Evaluation**: Traditional benchmarks focus on isolated capabilities (like retrieval or reasoning) or specific tasks (factual question-answering or fact verification) in a restricted way (zero-shot, single-shot, etc), rather than assessing how a typical user would use an AI system to achieve their goal. 

These limitations underscore the need for new benchmark frameworks specifically designed to evaluate AI systems' effectiveness in enterprise contexts, with particular attention to real-world data complexity, privacy requirements, and task complexity.

### Related Technical Approaches and their Limitations

We will briefly overview few common approaches to build systems on enterprise data and discuss their limitations.

**RAG**: RAG is a type of retrieval-augmented approach[^10],[^11],[^36] where text-embedding based search is used to enhance the grounding of the responses generated by the LLM. More recently, techniques like GraphRAG[^41] aim to augment text-embedding search with other techniques (like building knowledge graphs) to improve task performance. Although few use-cases like "needle in the haystack" search (described later) cater well to RAG approaches, it faces key limitations: lack of temporal awareness and attribute filtering, challenging to maintain user authorization with embeddings based search, and perhaps most importantly: limited to textual data.

**Text-to-SQL**: Database question-answering leverages text-to-SQL[^12] systems for data retrieval, but is limited in it's scope. The reality of  enterprise data is that it's usually spread across multiple databases and is stored in different column formats (complex types like JSON/STRUCT also becoming quite common). Moreover, SQL systems can only ever answer filter-based search or data aggregation kind of questions. SQL's inherent limitations make it unsuitable for tasks like summarization, classification and business-logic based computations.

**Tool use**: Tool use[^25], [^30] in LLMs provides the most flexible approach for retrieving data and executing tasks, but faces practical challenges: missing APIs, poor documentation for APIs, and increased hallucination risk when handling large data inputs for these tools. These limitations significantly impact the reliability of tool use based approaches in real-world environments.

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

1. **Attribute Search**: Retrieving data from a database by filtering or ordering by attributes
2. **Multi-step Data Retrieval**: Tasks requiring data fetching from multiple sources
3. **Data Aggregation**: Computing statistics (count, sum, min, max, avg, etc) from raw data
4. **Summarization/General Analysis**: Retrieving relevant data and giving a general summary (statistical or textual)
5. **Bulk Insights**: Analyzing multiple data items to extract specific insights
6. **Bulk Classification**: Finding relevant items using textual classification
7. **Decision Making**: Involves analyzing different data and making informed choices as to next course of action
8. **Clustering**: Identifying similar properties in bulk data
9. **"Needle in a haystack" Search**: Searching for all relevant documentes relevant for a query string
10. **Point Search**: Finding specific items which satisfy complex descriptions
11. **Structured Information Extraction**: Extracting key-value pairs from unstructured text
12. **Data Visualization**: Transforming data into human-friendly formats
13. **Action**: Tasks that have a permanent effect on the state of the data

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

The Data Access Agent Benchmark employs a goal-oriented evaluation metric[^42], recognizing that while many dataset questions could be approached in a zero-shot (or question-answer) setting, users typically interact with the agent through an assistant. This interaction often evolves into a dialogue where users provide helpful hints to guide task completion based on previous responses.

Most evaluation studies on dialogue systems follow the PARADISE[^43] framework. This framework evaluates user satisfaction through two key metrics: dialogue cost and task success. Dialogue cost measures interaction costs, such as the number of conversation turns, while task success assesses whether the system successfully achieves the user's goal. We can use a weighted combination of both metrics to come up with an overall score, although we believe that the task success alone may be reasonably considered as the main metric.

Given the challenges of evaluating dialogue responses on enterprise settings[^19], we will mainly rely on human assessment of the dialogues to measure the metrics.

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
[^19]: Ham et al. (2023). Challenges in Deploying Task-Oriented Dialogue Systems in Enterprise Settings
[^20]: Yu et al. (2018). Spider: A Large-Scale Human-Labeled Dataset for Complex and Cross-Domain Semantic Parsing and Text-to-SQL Task
[^21]: Wang et al. (2023). Semantic Parsing in Enterprise: Current Status and Future Directions
[^22]: Li et al. (2023). Complex Query Construction for Modern Database Question Answering Systems
[^24]: MultiHop-RAG: Benchmarking Retrieval-Augmented Generation for Multi-Hop Queries
[^25]: Toolformer: Language Models Can Teach Themselves to Use Tools
[^26]: ToolQA: A Dataset for LLM Question Answering with External Tools
[^27]: API-Bank: A Comprehensive Benchmark for Tool-Augmented LLMs
[^29]: Augmented Language Models: a Survey https://arxiv.org/pdf/2302.07842
[^30]: ReAct: Synergizing Reasoning and Acting in Language Models
[^31]: HotpotQA: A Dataset for Diverse, Explainable Multi-hop Question Answering
[^32]: GAIA: A Benchmark for General AI Assistants
[^33]: Retrieval-Augmented Generation for AI-Generated Content: A Survey
[^34]: Srivastava et al. (2022). Beyond the Imitation Game: Quantifying and extrapolating the capabilities of language models
[^35]: AGIEval: A Human-Centric Benchmark for Evaluating Foundation Models
[^36]: Improving language models by retrieving from trillions of tokens
[^37]: MTEB: Massive Text Embedding Benchmark
[^38]: FEVER: a large-scale dataset for Fact Extraction and VERification
[^39]: On the Tool Manipulation Capability of Open-source Large Language Models
[^40]: Gorilla: Large Language Model Connected with Massive APIs
[^41]: From Local to Global: A Graph RAG Approach to Query-Focused Summarization
[^42]: Recent Advances and Challenges in Task-oriented Dialog Systems
[^43]: PARADISE: A Framework for Evaluating Spoken Dialogue Agents
[^44]: Grounding and Evaluation for Large Language Models: Practical Challenges and Lessons Learned 
[^45]: Few-shot Fine-tuning vs. In-context Learning: A Fair Comparison and Evaluation





