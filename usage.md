<!--- This usage.md stores the instructions for bundle.zip, put through md to html parser --->

## Deploy My Hack usage 

1. Extract the downloaded bundle containing deployment scripts

unzip the contents of bundle.zip to your project directory. It should look something like this:
```
action-testing/
├── app.py
├── .github
│   └── workflows
│       └── deploy_bundle.yml
└── deploy_bundle
│   ├── README.md
│   ├── ansible.cfg
│   ├── ansible.py
│   ├── cleanup.yml
│   ├── flaskapp.conf
│   ├── nginx.conf
│   ├── nginx.yml
│   ├── resources.tf
│   ├── tasks
│   │   └── python.yml
│   └── templates
│       ├── inventory-template.yml
│       └── vars-template.yml
├── static
│   └── ...
├── templates
│   └── ...
└── other_project_files
    └── ...
```

2. Commit the `.github/workflows` and `deploy_bundle` folders to your repository 

```
git add . 
git commit -m "Add auto-deploy scripts"
git push
```

3. Save Google Cloud Platform credentials to GitHub secrets 

[https://docs.github.com/en/actions/security-guides/using-secrets-in-github-actions](GitHub documentation for creating secrets)

4. Done!

On pushes to your branches, the GitHub action will run and deploy your changes. You can see the runs in the "Actions" tab in your repository.
