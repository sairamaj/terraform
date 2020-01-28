import terraform
import sys

# x =  [
#                 'lib\\terraform.exe',
#                 'apply',
#                 '--auto-approve',
#                 '-var-file=\"input.tfvars\"',
#                 "samples\\usingvariables",
#             ]

# print(" ".join(x))
# quit()

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

