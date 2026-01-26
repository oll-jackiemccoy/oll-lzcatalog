# Landing Zone Catalog

> **Because no two projects are the same.**

The **Landing Zone Catalog** is a collection of reusable Terraform modules and example implementations designed to help you build **flexible, configurable AWS landing zones**. Rather than enforcing a single rigid design, this catalog allows you to compose a landing zone that matches each customer’s organizational, security, networking, and operational requirements.

This repository assumes that **AWS Organizations and AWS Control Tower already exist** and focuses on what comes *after* the initial Control Tower setup.

---

## 🎯 Goals

- Provide **modular Terraform building blocks** for AWS landing zones
- Support **multiple customer patterns**, not a one-size-fits-all approach
- Enable **incremental adoption** (use only the modules you need)
- Offer **real-world examples** showing how modules can be composed together

---

## 🧱 What This Catalog Includes

- Reusable Terraform modules for common landing zone components (e.g., networking, shared services, security primitives, governance helpers)
- Example configurations demonstrating how to assemble modules into a complete landing zone
- Patterns that work **with** existing AWS Organizations and Control Tower environments

---

## 🚫 What This Catalog Does *Not* Include

To keep the scope focused and flexible, the following are **explicitly out of scope**:

- ❌ Initial AWS Organizations setup
- ❌ AWS Control Tower deployment via console or AWS Landing Zone Accelerator (LZA)
- ❌ **Account Factory for Terraform (AFT)**

If a customer wants to manage AWS Control Tower *itself* using Terraform, refer to HashiCorp’s official guidance:

👉 https://developer.hashicorp.com/terraform/tutorials/aws/aws-control-tower-aft

> This repository is designed to **complement** Control Tower, not replace or reimplement it.

---

## 📐 Assumptions

Before using this catalog, the following are assumed to already be in place:

- AWS Organizations is enabled
- AWS Control Tower is already deployed
  - Either via **AWS Landing Zone Accelerator (LZA)**
  - Or **manually through the AWS Console**
- Required AWS accounts (management, audit, log archive, etc.) already exist

---

## 🗂️ Repository Structure

```text
.
├── modules/        # Reusable Terraform modules
│   ├── networking/
│   ├── shared-services/
│   ├── security/
│   └── ...
├── examples/       # End-to-end and partial landing zone examples
│   ├── basic/
│   ├── multi-account/
│   └── ...
├── docs/           # Architecture notes and design guidance (optional)
└── README.md
```

> Module boundaries are intentional—customers can mix, match, or omit components as needed.

---

## 🚀 How to Use This Repository

1. **Review the examples** to understand supported patterns
2. **Select the modules** that align with your customer’s requirements
3. Copy or reference the modules into your Terraform configuration
4. Customize variables, providers, and account mappings as needed

Each example is designed to be:
- Readable
- Minimal
- Easy to adapt to real customer environments

---

## 🧩 Design Philosophy

- **Composable over prescriptive** – build what you need, skip what you don’t
- **Customer-driven** – architecture should reflect business and security needs
- **Terraform-native** – no magic wrappers or hidden automation
- **Control Tower–aware** – respects guardrails, OUs, and existing governance

---

## 🛠️ Prerequisites

- Terraform (version specified per module)
- AWS credentials with appropriate cross-account permissions
- Familiarity with:
  - AWS Organizations
  - AWS Control Tower
  - Terraform module composition

---

## 🤝 Contributing

Contributions are welcome.

- New modules should be:
  - Well-documented
  - Opinionated but configurable
  - Safe to consume in multi-account environments
- Examples should reflect **real customer scenarios**, not theoretical ones

Please include documentation and example usage with any contribution.

---

## 📬 Questions or Ideas?

If you’re unsure whether a pattern belongs in this catalog, that’s usually a good sign it *does*. Open an issue or start a discussion.

**Every landing zone is different—this catalog exists to embrace that reality.**

