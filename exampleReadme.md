# HelloID-Conn-Prov-Target-{{connectorName}}

## Introduction

_HelloID-Conn-Prov-Target-{{connectorName}}_ is a **target connector** for HelloID.  
The _{{connectorName}}_ system provides a set of REST APIs that allow you to programmatically manage users and related resources.  

This connector automates the following standard HelloID lifecycle actions:
- Create account
- Update account
- Delete account
- Retrieve account information

> 🧠 *AI Insertion Point:*  
> The connector name `{{connectorName}}` and its API description will be filled in automatically by the **ConnectorBuilder Orchestrator** using data extracted from the provided Swagger/OpenAPI specification.

---

## Development Resources

### API Endpoints

Below are the primary endpoints derived from the provided Swagger specification.  
These will be automatically summarized and listed by the AI agent.

| Endpoint | HTTP Method | Description |
| -------- | ------------ | ------------ |
| {{AI_INSERT_GET}} | GET | {{AI_DESC_GET}} |
| {{AI_INSERT_CREATE}} | POST | {{AI_DESC_CREATE}} |
| {{AI_INSERT_UPDATE}} | PUT/PATCH | {{AI_DESC_UPDATE}} |
| {{AI_INSERT_DELETE}} | DELETE | {{AI_DESC_DELETE}} |

> 🧠 *AI Insertion Point:*  
> The Semantic Kernel agent will:
> - Parse the Swagger YAML  
> - Identify user-related API endpoints  
> - Summarize and populate these placeholders with accurate paths and short descriptions.

---
