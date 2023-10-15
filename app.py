from flask import Flask, config, json, render_template, request, Response, abort, jsonify, send_file
from terraform import render_gcp_terraform
import string
import tempfile
import zipfile
import os
import shutil

app = Flask(__name__)

@app.route('/gen_bundle/', methods=['GET'])
def generate_bundle_request():
    payload: dict = request.get_json()

    if "project_name" not in payload:
        abort(400)
    payload["project_name"] = payload["project_name"].lower()
    payload["project_name"] = payload["project_name"].replace("_", "-").replace(" ", "-")
    if any(x not in (string.ascii_letters+string.digits+"-") for x in payload["project_name"]) or len(payload["project_name"]) > 16:
        abort(400)

    terraform = render_gcp_terraform(**payload)
    tempdir_obj = tempfile.TemporaryDirectory()
    tempdir = tempdir_obj.name
    shutil.copytree("./ansible", f"{tempdir}/deploy_bundle")
    f = open(f"{tempdir}/deploy_bundle/resources.tf", "x")
    f.write(terraform)
    f.close()
    os.mkdir(f"{tempdir}/.github")
    os.mkdir(f"{tempdir}/.github/workflows")
    shutil.copy("./action.yml", f"{tempdir}/.github/workflows/deploy_bundle.yml")

    zip_path_obj = tempfile.TemporaryDirectory()
    zip_path = zip_path_obj.name
    shutil.make_archive(f"{zip_path}/bundle", 'zip', tempdir)

    return send_file(f"{zip_path}/bundle.zip")

if __name__ == "__main__":
    app.run()
