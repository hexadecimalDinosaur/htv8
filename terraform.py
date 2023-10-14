from re import template
from jinja2 import Environment, PackageLoader, select_autoescape

env = Environment(
    loader=PackageLoader("terraform", "terraform"),
    autoescape=select_autoescape()
)

template = env.get_template("gcp.tf")

print(template.render(
    gcp_project_id="omega-presence-402013",
    gcp_region="northamerica-northeast2",
    gcp_zone="northamerica-northeast2-a",
    project_name="testing",
    compute_type="e2-micro",
    managed_db=False
))
