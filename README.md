# kubernetes-minishift-openshift

## How to configure Minikube on windows

Step 1: Create Directory in C:/ Drive name with minikube-bin.
$ mkdir /c/minikube-bin

Step 2: In below repository try to download file name minikube-windows-amd64.exe from [Asset] and just rename this to minikube.exe and place it in C Drive.
https://github.com/kubernetes/minikube/releases
https://github.com/kubernetes/minikube/releases/download/v0.34.1/minikube-windows-amd64

$ cd  /c/minikube-bin
$ mv minikube-windows-amd64 minikube.exe

Step 3: Download below kubectl.exe file place it in C Drive
$ cd  /c/minikube-bin
$ curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.13.0/bin/windows/amd64/kubectl.exe

Step 4: Add "minikube-bin" path in PATH Environment variable. 

step 5: To start minikube run below command.
$ minikube.exe start

step 6: To start minikube dashboad run below command.
$ minikube.exe dashboard
