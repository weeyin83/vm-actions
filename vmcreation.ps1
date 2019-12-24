az group create --name rg-githubactions --location eastus

az vm create \
    --resource-group rg-githubactions \
    --name myVM \
    --image win2016datacenter \
    --admin-username sarah-admin \
    --admin-password !Verb0se!
