from enum import Enum
from jinja2 import Environment, PackageLoader, select_autoescape

env = Environment(
    loader=PackageLoader("terraform", "terraform"),
    autoescape=select_autoescape()
)

template = env.get_template("gcp.tf")

def render_gcp_terraform(project_name, gcp_project_id: str, gcp_region="northamerica-northeast2", gcp_zone="northamerica-northeast2-a", compute_type="e2-micro", managed_db=False, managed_db_version="POSTGRES_15", managed_db_tier="db-f1-micro") -> str:
    return template.render(
        gcp_project_id=gcp_project_id,
        gcp_region=gcp_region,
        gcp_zone=gcp_zone,
        project_name=project_name,
        compute_type=compute_type,
        managed_db=managed_db,
        managed_db_version=managed_db_version,
        managed_db_tier=managed_db_tier
    )
