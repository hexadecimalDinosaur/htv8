# InfraBundle
Submitted to Hack the Valley 8.0

## 💡 Inspiration

> \#hackathon-help-channel 
`<hacker>` Can a mentor help us with flask and Python? We're stuck on how to host our project.

How many times have you created an epic web app for a hackathon but couldn't deploy it to show publicly? At my first hackathon, my team worked hard on a Django + React app that only lived at `localhost:5000`.

Many new developers don't have the infrastructure experience and knowledge required to deploy many of the amazing web apps they create for hackathons and side projects to the cloud. 

We wanted to make a tool that enables developers to share their projects through deployments without any cloud infrastructure/DevOps knowledge

(Also, as 2 interns currently working in DevOps positions, we've been learning about lots of Infrastructure as Code (IaC), Configuration as Code (CaC), and automation tools, and we wanted to create a project to apply our learning.)
## 💭 What it does

InfraBundle aims to: 
1. ask a user for information about their project 
2. generate appropriate IaC and CaC code configurations
3. bundle configurations with GitHub Actions workflow to simplify deployment

Then, developers commit the bundle to their project repository where deployments become as easy as pushing to your branch (literally, that's the trigger).

## 🚧 How we built it
As DevOps interns, we work with Ansible, Terraform, and CI/CD pipelines in an enterprise environment. We  thought that these could help simplify the deployment process for hobbyists as well

InfraBundle uses: 
- Ansible (CaC)
- Terraform  (IaC)
- GitHub Actions  (CI/CD)
- Python and jinja (generating CaC, IaC from templates)
- flask! (website)

## 😭 Challenges we ran into
We're relatitvely new to Terraform and Ansible and stumbled into some trouble with all the nitty-gritty aspects of setting up scripts from scratch. 

In particular, we had trouble connecting an SSH key to the GitHub Action workflow for Ansible to use in each run. This led to the creation of temporary credentials that are generated in each run. 

With Ansible, we had trouble creating and activating a virtual environment  (see: not carefully reading [ansible.builtin.pip](https://docs.ansible.com/ansible/latest/collections/ansible/builtin/pip_module.html) documentation on which parameters are mutually exclusive and confusing the multiple ways to pip install)

In general, hackathons are very time constrained. Unfortunately, slow pipelines do not care about your time constraints.
- hard to test locally 
- cluttering commit history when debugging pipelines

## 🏆 Accomplishments that we're proud of
InfraBundle is capable of deploying itself! 

In other news, we're proud of the project being something we're genuinely interested in as a way to apply our learning. Although there's more functionality we wished to implement, we learned a lot about the tools used. We also used a GitHub project board to keep track of tasks for each step of the automation.

## 📘 What we learned
Although we've deployed many times before, we learned a lot about automating the full deployment process. This involved handling data between tools and environments. We also learned to use GitHub Actions.

## ❓ What's next for InfraBundle
InfraBundle currently only works for a subset of Python web apps and the only provider is Google Cloud Platform. 
With more time, we hope to: 
- Add more cloud providers (AWS, Linode)
- Support more frameworks and languages (ReactJS, Express, Next.js, Gin)
- Improve support for database servers
- Improve documentation 
- Modularize deploy playbook to use roles 
- Integrate with GitHub and Google Cloud Platform
- Support multiple web servers
