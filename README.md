# Introducing the Data Access Agent Benchmark

An open problem in enterprise AI deployment is building systems that can effectively access, process, and reason over private organizational data. While language models have shown impressive capabilities with public knowledge, their ability to work with private enterprise data remains limited. Most enterprise AI assistants today can only handle basic predefined workflows and struggle with novel requests or complex data operations.

To address this challenge and measure the effectiveness of AI systems in enterprise settings, we are releasing the Data Access Agent Benchmark (DAAB), a comprehensive evaluation framework for assessing AI systems' ability to work with private enterprise data.

## Prior Art and Motivation

The landscape of AI benchmarks has evolved significantly over the past decade. Early benchmarks like SQuAD[^1] and TriviaQA[^2] focused on question-answering capabilities of models over public text. More recent benchmarks like MMLU[^3] and Big-Bench[^4] evaluate broader reasoning capabilities and tool use. Agent-focused benchmarks such as AgentBench[^5] assess the ability of AI systems to execute complex tasks through tool interaction.

However, these benchmarks have significant limitations when it comes to enterprise settings:

1. **Public vs. Private Data**: Most existing benchmarks focus on public knowledge rather than private organizational data. While OpenAI's SimpleQA[^6] addresses factuality, it doesn't capture the challenges of accessing and processing private enterprise data. AKA open domain vs closed domain

2. **Single Model vs. System Evaluation**: Traditional benchmarks evaluate individual model capabilities rather than complete AI systems. Frameworks like LangChain[^7] and AutoGPT[^8] demonstrate the need for evaluating entire system architectures.

3. **Synthetic vs. Real-world Tasks**: Many benchmarks use synthetic or academic tasks rather than real enterprise workflows. While BIG-bench[^4] includes diverse tasks, it lacks the complexity of actual business operations.

4. **Static vs. Dynamic Data**: Existing benchmarks often use static datasets, whereas enterprise systems must handle dynamic, constantly updating data sources.

These limitations highlight the need for a new type of benchmark that can evaluate AI systems' ability to work with enterprise data in realistic scenarios.

### Related Technical Foundations

Our benchmark builds upon several key technical areas in AI:

1. **Retrieval Augmented Generation (RAG)**
   - Early work by Lewis et al.[^14] introduced RAG as a way to ground language model outputs in retrieved documents
   - Chen et al.[^15] demonstrated RAG's effectiveness in enterprise settings
   - Current challenges include retrieval quality and context integration[^16]
   - FRAMES: Fact, Fetch, and Reason: A Unified Evaluation of Retrieval-Augmented Generation[^23]
   - MultiHop-RAG: Benchmarking Retrieval-Augmented Generation for Multi-Hop Queries[^24]

2. **Tool use in LLMs**
   - Toolformer: Language Models Can Teach Themselves to Use Tools[^25]
   - ToolQA: A Dataset for LLM Question Answering with External Tools[^26]
   - API-Bank: A Comprehensive Benchmark for Tool-Augmented LLMs[^27]

3. **Database Question Answering**
   - Text-to-SQL systems like Spider[^20] pioneered structured data access
   - Recent advances in semantic parsing for database queries[^21]
   - Challenges in complex joins and nested queries[^22]

These foundations inform several aspects of our benchmark:
- RAG techniques influence our evaluation of data retrieval efficiency
- Tool use influences planning ability
- Database QA challenges guide our data access complexity metrics

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
[^3]: Hendrycks et al. (2020). Measuring Massive Multitask Language Understanding
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
[^14]: Lewis et al. (2020). Retrieval-Augmented Generation for Knowledge-Intensive NLP Tasks
[^15]: Chen et al. (2022). Enterprise RAG: Improving Business Document Retrieval with Large Language Models
[^16]: Shi et al. (2023). A Survey of Retrieval-Augmented Text Generation
[^17]: Budzianowski et al. (2018). MultiWOZ - A Large-Scale Multi-Domain Wizard-of-Oz Dataset for Task-Oriented Dialogue Modelling
[^18]: Hosseini-Asl et al. (2020). A Simple Language Model for Task-Oriented Dialogue
[^19]: Ham et al. (2023). Challenges in Deploying Task-Oriented Dialogue Systems in Enterprise Settings
[^20]: Yu et al. (2018). Spider: A Large-Scale Human-Labeled Dataset for Complex and Cross-Domain Semantic Parsing and Text-to-SQL Task
[^21]: Wang et al. (2023). Semantic Parsing in Enterprise: Current Status and Future Directions
[^22]: Li et al. (2023). Complex Query Construction for Modern Database Question Answering Systems
[^23]: FRAMES: Fact, Fetch, and Reason: A Unified Evaluation of Retrieval-Augmented Generation
[^24]: MultiHop-RAG: Benchmarking Retrieval-Augmented Generation for Multi-Hop Queries
[^25]: Toolformer: Language Models Can Teach Themselves to Use Tools
[^26]: ToolQA: A Dataset for LLM Question Answering with External Tools
[^27]: API-Bank: A Comprehensive Benchmark for Tool-Augmented LLMs
[^28]: ACUTE-EVAL: Improved Dialogue Evaluation with Optimized Questions and Multi-turn Comparisons



