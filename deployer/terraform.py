import subprocess
import os
import shutil
from os import path


class Terraform():
    def __init__(self, path):
        self.path = path

    def init(self):
        process = subprocess.Popen(['lib\\terraform.exe', 'init', self.path])
        stdout, stderr = process.communicate()
        stdout, stderr

    def apply(self):
        print(f'path: {self.path}')
        process = subprocess.Popen(
            [
                'lib\\terraform.exe',
                'apply',
                '--auto-approve',
                '-var-file=input.tfvars',
                self.path, 
            ])
        stdout, stderr = process.communicate()
        stdout, stderr

    def clean(self):
        if path.exists('terraform.tfstate'):
            os.remove('terraform.tfstate')
        if path.exists('terraform.tfstate.backup'):
            os.remove('terraform.tfstate.backup')
        # if path.exists('.terraform'):
        #     shutil.rmtree('.terraform')
