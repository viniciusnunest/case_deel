# Analytics Engineering Project

## Overview

This project involves comprehensive data analysis and visualization, structured around the principles of analytics engineering. It utilizes modern data stack technologies including dbt for data modeling, Snowflake for database management, and Lightdash for visualization.

### Preliminary Data Exploration

The initial phase involved reviewing CSV files to define the schema and conducting select queries to understand data structure and relationships. This foundational work was essential for setting up the project.

### Data Model Architecture


The architecture was designed based on the official dbt documentation. Explore the organization of the files, folders, and models within the models directory for our three primary layers, each building upon the other.
  i. Staging — creating our atoms, our initial modular building blocks, from source data
  ii. Intermediate — stacking layers of logic with clear and specific purposes to prepare our staging models to join into the entities we want
  iii. Marts — bringing together our modular pieces into a wide, rich vision of the entities our organization cares about
  
Here, I also relied on the medallion architecture, although it wasn't followed in every detail, it served as one of the inspirations. (ref: [dataengineeringwiki](https://dataengineering.wiki/Concepts/Medallion+Architecture))

### Lineage Graphs

Generated using `dbt docs generate`, providing a visual representation of model relationships and data flow, accessible through `dbt docs serve`.
<img width="1468" alt="image" src="https://github.com/viniciusnunest/dbt_snowflake_orchestrated_by_gh_actions/assets/104783995/64d8601f-6207-4b59-8d79-2db6a861daa7">


### Macros and Jinja

In this project, I implemented a single macro to enhance code readability and reusability by converting boolean values to integers. This is achieved by simply invoking the macro with `{{ bool_to_int('field') }}`. To further streamline the code, a macro from the `dbt-utils` package was utilized for efficient `group by` operations on columns using `{{ dbt_utils.group_by(n=6) }}`. Jinja templating played a crucial role in performing a `union all` operation and transforming the 'rates' field into a currencies table, minimizing the risk of human error and simplifying maintenance. This approach involved using Jinja to execute a loop over currencies and implementing a test to ensure only accepted currency values are processed.


### Data Validation

Tests were employed across their respective layers to ensure data quality and validation, ranging from simpler yet extremely important tests, such as uniqueness and non-nullity, to more complex tests like relationships. For example, the relationship between the chargeback source and the acceptance source was tested to ensure that all transactions marked as chargeback are present in the acceptance table. Additionally, the elementary package (an excellent tool that assists with testing and the consumption of artifacts) was used to test for data anomalies in the acceptance table, as well as to perform accepted values tests.

### Documentation and Tools

In this project, the data storage solution utilized is Amazon S3, with Snowflake serving as the database. Data modeling is performed using dbt, Lightdash is employed for visualization purposes, and GitHub is utilized for code management, complemented by GitHub Actions for orchestration. The data flow begins with setting up tables and loading data directly from S3. The project is organized into three distinct databases for managing different stages of data: raw, development, and production, each serving a specific purpose and managed through GitHub Actions.

The data modeling process in dbt is divided into several stages: Staging, Intermediate, Marts, and Exposures, each serving a unique role from building basic data blocks to compiling comprehensive views and outlining data usage in dashboards. The project incorporates two primary sources and models, focusing on standardizing transaction values and enabling currency conversions. A detailed 'dm_payment__overview' model aggregates data for analytics and dashboard development, ensuring accuracy and flexibility for future analyses.

Documentation is meticulously maintained on GitHub, offering a single source of truth for the project. For visualization, Lightdash integrates directly with the dbt project, transforming it into a dynamic BI platform. This setup facilitates the definition of metrics and dimensions in the schema.yml, allowing for the creation of insightful, dynamic dashboards that reflect the analytical depth of the project.

- Example dimension:
  <img width="467" alt="image" src="https://github.com/viniciusnunest/dbt_snowflake_orchestrated_by_gh_actions/assets/104783995/59854c8c-0846-42bf-a9eb-20682254b612">
- Example measure/metric:
  <img width="464" alt="image" src="https://github.com/viniciusnunest/dbt_snowflake_orchestrated_by_gh_actions/assets/104783995/4095a1c1-54c4-4d4d-a561-0edc0c18b464">
 
To make all of this possible, I leveraged GitHub for comprehensive code management and versioning. I created branches with descriptive names to clearly indicate the ongoing work, along with setting up GitHub Actions for automation:

  - To execute the project upon opening a pull request, serving almost as a continuous integration (CI) system to ensure everything was functioning correctly.
  - To run the entire project daily at 09:00 AM UTC and to deploy Lightdash, making all the marts from the daily DAG available in Lightdash for use. This setup provided a robust framework for ensuring code quality and facilitating seamless deployment.
    
These actions were stored in the .github/workflows folder within the project. This organization allows for a structured approach to automating our processes, ensuring that the GitHub Actions are easily accessible and well-managed, contributing to the efficiency and reliability of our deployment and integration practices.
