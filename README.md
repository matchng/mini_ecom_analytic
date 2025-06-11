# Mini E-commerce Analytics Project

## Description
This project simulates a real-world data engineering workflow using synthetic (non-sensitive) e-commerce sales data. It showcases the end-to-end process of ingesting, storing, and visualizing data with PostgreSQL, pgAdmin, Metabase, and Docker.

## Project Goals

The objective is to gain hands-on, practical experience with key tools in the modern data engineering stack by recreating a simplified version of a data pipeline. This project is part of my personal learning journey to reinforce concepts learned from DataCamp and LinkedIn Learning.

## Tech Stack
| Tool                        | Purpose                                                                                                           |
| --------------------------- | ----------------------------------------------------------------------------------------------------------------- |
| **PostgreSQL**              | Relational database used to store structured e-commerce data                                                      |
| **pgAdmin**                 | Web-based GUI tool to interact with and manage the PostgreSQL database                                            |
| **Metabase**                | Data visualization tool used for data exploration and building dashboards                                         |
| **Docker & Docker Compose** | Containerized setup to run PostgreSQL, pgAdmin, and Metabase in isolated, reproducible environments               |
| **SQL**                     | Used for data transformation, aggregation and analysis                                                            |

## Project Architecture

The diagram below illustrates the overall architecture of this project and how each component interacts with one another.

![Project Architecture](./asset/mini_ecom_architech.drawio.svg)

## 🛠️ Setup & Getting Started 

To run this project locally:

1. **Clone the repository**:
   git clone https://github.com/yourusername/mini_ecom_analytic.git
   
   cd mini_ecom_analytic

2. **Create your own environment file**
    Copy the .env example file and customize it as needed.
   
    cp .env.example .env

3. **Start the services using Docker Compose**
    docker compose up --build

4. **Access the tools as below:**
    pgAdmin: http://localhost:8080
    Metabase: http://localhost:3000

