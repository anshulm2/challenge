Use the below command to activate the service account
gcloud auth activate-service-account service_account_name --key-file=jsonkeyfilepath

We have 2 gcloud commands in our file.

First command would be used to get the whole metadata for the VM, which would be specified by providing the instance id and the zone.

In the second command, we can pass the key value in my_key parameter, it would provide the value in the ouput.
