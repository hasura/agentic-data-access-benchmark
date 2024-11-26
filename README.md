# Introducing the Data Access Agent Benchmark

**Abstract**

An open problem in enterprise AI deployment is building systems that can effectively access, process, and reason over private organizational data. While language models have shown impressive capabilities with public knowledge, their ability to work with private enterprise data remains limited. Most enterprise AI assistants today can only handle basic predefined workflows and struggle with novel requests or complex data operations. To address this challenge and measure the effectiveness of AI systems in enterprise settings, we are releasing the Data Access Agent Benchmark (DAAB), a comprehensive evaluation framework for assessing AI systems' ability to work with private enterprise data.

## Introduction

An open problem in enterprise AI deployment is building systems that can effectively access, process, and reason over private organizational data. While language models have shown impressive capabilities with public knowledge, their ability to work with private enterprise data remains limited. Most enterprise AI assistants today can only handle basic predefined workflows and struggle with novel requests or complex data operations. To address this challenge and measure the effectiveness of AI systems in enterprise settings, we are releasing the Data Access Agent Benchmark (DAAB), a comprehensive evaluation framework for assessing AI systems' ability to work with private enterprise data.

The ability of an AI system to autonomously access and operate on enterprise data - what we call "agentic data access" - is crucial for building truly useful enterprise AI solutions. DAAB is designed to evaluate complete AI systems, which may include multiple models, tools, and retrieval pipelines, rather than focusing on individual models or components in isolation.

Current benchmarks face several limitations when applied to enterprise settings:

*Data Privacy Context*: Existing benchmarks predominantly focus on public knowledge. While they can incorporate retrieval and tool use, they fail to capture the unique challenges of private organizational data. Enterprise environments typically involve sensitive, proprietary information based on dynamic security rules.

*Data Source Complexity*: Traditional benchmarks evaluate performance on a single source of data or database. Enterprise data typically spans multiple systems and formats. Integration challenges are often overlooked in current evaluations.

*Task Authenticity*: Most benchmarks rely on synthetic or academic tasks (factual question-answering on wikipedia like data being most common). Even advanced datasets like GAIA29 fail to capture typical business queries. Real business questions often involve a combination of information retrieval, exploration and decision making.

*Data Dynamism*: Existing benchmarks typically use static datasets. Enterprise systems must handle dynamic, continuously updating data sources.

*User-goal Evaluation*: Traditional benchmarks focus on isolated capabilities (like retrieval or reasoning) or specific tasks (factual question-answering or fact verification) in a restricted way e.g. single attempt answer, rather than assessing how a typical user would use an AI system to achieve their goal.

With DAAB, our goal is to create a set of real-world questions/user-goals with characteristics such as:
1. Real-world relevance: Questions are derived from actual enterprise use cases across different domains like Customer Support, Sales, HR and Engineering Management
2. Comprehensive evaluation: The benchmark tests various complexity levels of data access and computation, from simple retrieval to complex multi-step operations
3. System-agnostic: The benchmark is meant to evaluate any AI system architecture, whether it uses a single large model or multiple specialized components

## Prior Art

### Evolution of LLM Benchmarks

The landscape of AI benchmarks has evolved significantly over the last few years. Early benchmarks like SQuAD, TriviaQA, and NaturalQuestions focused primarily on evaluating question-answering capabilities over public information (mainly using Wikipedia as source of truth). For database question-answering, specialized datasets like Spider, WikiSQL, and BIRD have emerged to evaluate a language model's ability to translate natural language queries into SQL statements (text-to-SQL). With the emergence of Large Language Models (LLMs), these traditional benchmarks have been largely surpassed. Recent evaluations like MMLU, AGIEval, Big-Bench (Hard) have ramped up efforts to assess broader reasoning and language understanding capabilities more appropriate for modern LLMs. There is still significant energy in both academia and industry in crafting representative datasets for benchmarking different LLM capabilities as seen most recently by OpenAI's SimpleQA benchmark.

### Benchmarks for LLMs with External Systems

While traditional benchmarks evaluate LLM capabilities relying on the implicit knowledge embedded within model parameters, a new set of benchmarks has emerged to assess LLM performance when augmented with external systems. Such augmentation is necessary when responses need to be grounded in facts that are present in these external systems. Though fine-tuning LLMs with additional data represents one augmentation approach, practical considerations like training costs, keeping models up-to-date, and security considerations have limited its industry adoption. Instead, current industry practices primarily fall into two categories:

1. **Retrieval-augmented approaches**: This approach incorporates explicit retrieval steps of relevant data from a large database and provided alongside the user input. Most classic benchmarks like TriviaQA and NaturalQuestions have been used for evaluating retrieval-augmented techniques by using a Wikipedia database. There are various benchmarks like MTEB which measure the capabilities of text embedding models (like S-BERT) typically used in the retrieval phase. More complex benchmarks like HotPotQA (for multi-hop questions) and FEVER (for fact verification) enhance the task complexity for LLMs and illustrate the need to use retrieval-augmented approaches. More recently, benchmarks like FRAMES and CRAG have emerged to make the questions in the dataset more real-world.

2. **Tool use**: Tool use enables LLMs to dynamically request and interact with external tools - from simple calculators to data APIs and web search capabilities. To measure the efficiency of an LLM to use tools correctly, benchmarks like ToolQA, API-Bank, APIBench (and subsequently BFCL[^55]) and ToolBench[^56] are used for evaluating tool use capability of the LLM. More recently, tool use for general assistants has paved the way for benchmarks like GAIA.

## About the Data Access Agent Benchmark

### Dataset

DAAB contains approximately 150 questions across different enterprise domains. Each question is categorized along multiple dimensions:

**Domain**: The domain the question belongs to. As of writing, this could be one of the 5 domains: Customer support, Email+calendar, Sales, HR and Engineering Management. More about these domains is described in Appendix A. Although these are specific domains, we hope that the use-cases in these domains are generalizable to any domain and hence provide valuable insights into different kinds of questions that a human user might ask an AI system.

**Agentic Complexity Level**: Complexity level is one of 3 values: Low, Medium, or High.

* Low: Questions which use a single planning component e.g. Get user with id=1. This is a straightforward lookup on the user table.
* Medium: Questions which require two planning components composed together e.g. Show me travel confirmation from American Airlines. This question requires looking up emails and classifying them as travel confirmation from American Airlines
* High: Questions which require more than two planning components composed together e.g. Summarize any interesting lead activities that I should look into for prospecting. This question requires retrieval of lead activities followed by classifying them as relevant for prospecting and finally summarizing all the results

**Agentic Complexity Aspects**: These are one of: Smart search strategy, Following connections, NLP compute and logic compute.

* Smart search strategy: This involves being able to choose a reasonable strategy for retrieving relevant data. This is especially important when it's not obvious what or how much data to retrieve
* Following connections: This involves getting related data by following connections to it. Usually insights and decision making is done by looking at a set of related data 
* NLP compute: This involves extracting valuable information from unstructured or textual data
* Logic compute: This involves numeric or logic based computation

**Use-case Category**: A fundamental use-case pattern. These are described in detail in the next section

### Use Case Categories

The benchmark identifies several fundamental use-case categories:

1. **Attribute search**: Attribute search is retrieving data by filtering or ordering on an attribute e.g. get user with id=1 or get latest ticket
2. **Multi-step data retrieval**: Tasks requiring data from multiple source to be fetched e.g. get the projects, invoices and usage for tina.jackson@gray-smith.com
3. **Data aggregation**: Tasks requiring computing statistics over raw data e.g. what's the average length of our sales cycle this year
4. **Summarization/General analysis**: Looking at sample data and aggregates to give an overview e.g. How are project creations looking this month
5. **Bulk insights**: Analyzing multiple data items and extracting key insights from each e.g. Give summary of all tickets created today
6. **Bulk classification**: Classify multiple data items into preset categories e.g. categorize all unlabled tickets as one of operational, feature request, bug report, how-to or others
7. **Decision making**: Involves analyzing different data and making informed choices as to next course of action e.g. help me resolve ticket 1234
8. **Clustering**: Identifying similar properties in bulk data e.g. Extract any common identified pain points for my opportunities
9. **Information search**: Searching for all relevant documents relevant for a query string e.g. product roadmap for q3
10. **Point search**: Finding specific items which satisfy complex descriptions e.g. Get the email where Tina mentioned performance issues
11. **Structured information extraction**: Extracting key-value pairs from unstructured text e.g. extract the invoice numbers, amounts, and due dates from uber last week
12. **Data visualization**: Human-friendly data transformation e.g. what is the breakup of lead sources this week?
13. **Action**: Tasks that have a state changing effect e.g. create reminder 10 mins before my next meeting

### Question distribution

[insert images]

## Evaluation Methodology

The Data Access Agent Benchmark employs a goal-oriented evaluation metric, recognizing that while many dataset questions could be approached in a zero-shot (or question-answer) setting, users typically interact with the agent through an assistant. This interaction often evolves into a dialogue where users provide helpful hints to guide task completion based on previous responses.

Most evaluation studies on dialogue systems follow the PARADISE framework. This framework evaluates user satisfaction through two key metrics: dialogue cost and task success. Dialogue cost measures interaction costs, such as the number of conversation turns, while task success assesses whether the system successfully achieves the user's goal. We can use a weighted combination of both metrics to come up with an overall score, although we believe that the task success alone may be reasonably considered as the main metric.

Given the challenges of evaluating dialogue responses on enterprise settings, we will mainly rely on human assessment of the dialogues to measure the metrics.

## Discussion: Technical Approaches and their Limitations

We will briefly overview few common approaches to build systems on enterprise data and discuss their limitations.

*RAG*: RAG is a type of retrieval-augmented approach where text-embedding based search is used to enhance the grounding of the responses generated by the LLM. More recently, techniques like GraphRAG aim to augment text-embedding search with other techniques (like building knowledge graphs) to improve task performance. Although few use-cases like information search (described later) cater well to RAG approaches, it faces key limitations: lack of temporal awareness and attribute filtering, challenging to maintain user authorization with embeddings based search, and perhaps most importantly: limited to textual data.

*text-to-SQL*: Database question-answering leverages text-to-SQL systems for data retrieval, but is limited in its scope. The reality of enterprise data is that it's usually spread across multiple databases and is stored in different column formats (complex types like JSON/STRUCT also becoming quite common). Moreover, SQL systems can only ever answer filter-based search or data aggregation kind of questions. SQL's inherent limitations make it unsuitable for tasks like summarization, classification and business-logic based computations.

*Tool use*: Tool use in LLMs provides the most flexible approach for retrieving data and executing tasks, but faces practical challenges: missing APIs, poor documentation for APIs, and increased hallucination risk when handling large data inputs for these tools. These limitations significantly impact the reliability of tool use based approaches in real-world environments.

## Extending DAAB and Future Work

[Section content not provided in original]

## Conclusion

The Data Access Agent Benchmark represents a significant step forward in evaluating enterprise AI systems' ability to work with private data. By providing a standardized way to assess these capabilities, we hope to drive progress in building more effective enterprise AI solutions that can truly understand and work with organizational data.

The complete benchmark dataset is available at [TODO: Add link to dataset].

We invite the AI community to use this benchmark in evaluating their enterprise AI systems and welcome feedback on making it even more useful for measuring progress in this crucial area.

## References

[1] AGIEval (2023) - "AGIEval: A Human-Centric Benchmark for Evaluating Foundation Models"

[2] API-Bank (2023) - "API-Bank: A Comprehensive Benchmark for Tool-Augmented LLMs"

[3] AutoGPT (2023) - "AutoGPT Documentation", Available at: https://docs.agpt.co/

[4] Zhong et al. (2017) - "Seq2SQL: Generating Structured Queries from Natural Language using Reinforcement Learning"

[5] Li et al. (2023) - "Can LLM Already Serve as A Database Interface? A BIg Bench for Large-Scale Database Grounded Text-to-SQLs"

[6] Borgeaud et al. (2022) - "Improving language models by retrieving from trillions of tokens"

[7] Chen et al. (2022) - "Enterprise RAG: Improving Business Document Retrieval with Large Language Models"

[8] Chevalier-Boisvert et al. (2018) - "BabyAI: First Steps Towards Grounded Language Learning With a Human In the Loop"

[9] Unknown (2023) - "Few-shot Fine-tuning vs. In-context Learning: A Fair Comparison and Evaluation"

[10] Unknown (2023) - "GAIA: A Benchmark for General AI Assistants"

[11] Unknown (2023) - "From Local to Global: A Graph RAG Approach to Query-Focused Summarization"

[12] Kenthapadi et al. (2024) - "Grounding and Evaluation for Large Language Models: Practical Challenges and Lessons Learned (Survey)"

[13] Ham et al. (2023) - "Challenges in Deploying Task-Oriented Dialogue Systems in Enterprise Settings"

[14] Hendrycks et al. (2020) - "Measuring Massive Multitask Language Understanding"

[15] Ji et al. (2023) - "Augmented Language Models: a Survey"

[16] Joshi et al. (2017) - "TriviaQA: A Large Scale Distantly Supervised Challenge Dataset for Reading Comprehension"

[17] LangChain (2023) - "LangChain Documentation", Available at: https://python.langchain.com/docs/

[18] Lewis et al. (2020) - "Retrieval-Augmented Generation for Knowledge-Intensive NLP Tasks"

[19] Li et al. (2023) - "Complex Query Construction for Modern Database Question Answering Systems"

[20] Li et al. (2023) - "Text-to-SQL: State of the Art and Future Directions"

[21] Liang et al. (2022) - "Holistic Evaluation of Language Models"

[22] Liu et al. (2023) - "AgentBench: Evaluating LLMs as Agents"

[23] Muennighoff et al. (2023) - "MTEB: Massive Text Embedding Benchmark"

[24] Unknown (2023) - "MultiHop-RAG: Benchmarking Retrieval-Augmented Generation for Multi-Hop Queries"

[25] Kwiatkowski et al. (2019) - "Natural Questions: A Benchmark for Question Answering Research"

[26] OpenAI (2023) - "OpenAI Evals Documentation", Available at: https://github.com/openai/evals

[27] Unknown (2023) - "Retrieval-Augmented Generation for AI-Generated Content: A Survey"

[28] Rajpurkar et al. (2016) - "SQuAD: 100,000+ Questions for Machine Comprehension of Text"

[29] Unknown (2023) - "Recent Advances and Challenges in Task-oriented Dialog Systems"

[30] Reimers & Gurevych (2019) - "Sentence-BERT: Sentence Embeddings using Siamese BERT-Networks"

[31] Schick et al. (2023) - "Toolformer: Language Models Can Teach Themselves to Use Tools"

[32] Shi et al. (2023) - "A Survey of Retrieval-Augmented Text Generation"

[33] Srivastava et al. (2022) - "Beyond the Imitation Game: Quantifying and extrapolating the capabilities of language models"

[34] Sun et al. (2023) - "Gorilla: Large Language Model Connected with Massive APIs"

[35] Thorne et al. (2018) - "FEVER: a large-scale dataset for Fact Extraction and VERification"

[36] Unknown (2023) - "ToolQA: A Dataset for LLM Question Answering with External Tools"

[37] Walker et al. (1997) - "PARADISE: A Framework for Evaluating Spoken Dialogue Agents"

[38] Wang et al. (2023) - "Semantic Parsing in Enterprise: Current Status and Future Directions"

[39] Wei et al. (2024) - "SimpleQA: A Factuality Benchmark for Language Models"

[40] Yang et al. (2018) - "HotpotQA: A Dataset for Diverse, Explainable Multi-hop Question Answering"

[41] Yao et al. (2023) - "ReAct: Synergizing Reasoning and Acting in Language Models"

[42] Yu et al. (2018) - "Spider: A Large-Scale Human-Labeled Dataset for Complex and Cross-Domain Semantic Parsing and Text-to-SQL Task"

[43] Zhang et al. (2022) - "Enterprise Search in the Era of Large Language Models"

[44] Srivastava et al. (2022) - "Beyond the Imitation Game: Quantifying and extrapolating the capabilities of language models"

[45] Suzgun et al. (2023) - "Challenging BIG-Bench Tasks and Whether Chain-of-Thought Can Solve Them"

[46] Chen et al. (2023) - "Few-shot Fine-tuning vs. In-context Learning: A Fair Comparison and Evaluation"

[47] Lin et al. (2024) - "FRAMES: Fact, Fetch, and Reason: A Unified Evaluation of Retrieval-Augmented Generation"

[48] Yang et al. (2024) - "CRAG -- Comprehensive RAG Benchmark"

[49] Qin et al. (2023) - "On the Tool Manipulation Capability of Open-source Large Language Models"

[50] Mialon et al. (2023) - "GAIA: A benchmark for General AI Assistants"

[51] Guu et al. (2020) - "REALM: Retrieval-Augmented Language Model Pre-Training"

[52] Zhang et al. (2020) - "Recent Advances and Challenges in Task-oriented Dialog System"

[53] Edge et al. (2024) - "From Local to Global: A Graph RAG Approach to Query-Focused Summarization"

[54] Liu et al. (2023) - "Text-to-SQL: State of the Art and Future Directions"

[55] Yan et al. (2024) - "Berkeley Function Calling Leaderboard" : https://gorilla.cs.berkeley.edu/blogs/8_berkeley_function_calling_leaderboard.html

[56] Qin et al. (2023) - "ToolLLM: Facilitating Large Language Models to Master 16000+ Real-world APIs"
