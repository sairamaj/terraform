import terraform
import sys


print(sys.argv)
if len(sys.argv) < 2:
    print('directory containing terraform is required.')
    quit()

path = sys.argv[1]
print(f'path is:{path}')

t = terraform.Terraform(path)
t.clean()
t.init()
t.apply()

