# azcopy login --aad-endpoint https://login.partner.microsoftonline.cn
 azcopy copy "https://md-qkgpzx5j4rsp.blob.core.chinacloudapi.cn/qbn2xcz0ksqr/abcd?sv=2018-03-28&sr=b&si=0d1e1f20-eeb8-489b-b252-96ce3fda4861&sig=EmOH8ZblR6o23%2FW3bH5I8yMItm4A%2Bu0nsGc7jIQV77A%3D" "https://xhtest2.blob.core.chinacloudapi.cn/test/test.vhd?sp=racwdl&st=2022-04-08T09:32:40Z&se=2022-04-08T17:32:40Z&spr=https&sv=2020-08-04&sr=c&sig=Vv9cF%2FbRBSHc7d9JO5GBeXISgxKcV6AdKcEVZKfQV5I%3D"
#azcopy -v /source:"https://md-qkgpzx5j4rsp.blob.core.chinacloudapi.cn /qbn2xcz0ksqr/abcd" /sourceSAS:"?sv=2018-03-28&sr=b&si=0d1e1f20-eeb8-489b-b252-96ce3fda4861&sig=EmOH8ZblR6o23%2FW3bH5I8yMItm4A%2Bu0nsGc7jIQV77A%3D" /dest:"https://xhtest2.blob.core.chinacloudapi.cn/test/testdisk.vhd" /destKey:"?sp=racwdl&st=2022-04-08T09:32:40Z&se=2022-04-08T17:32:40Z&spr=https&sv=2020-08-04&sr=c&sig=Vv9cF%2FbRBSHc7d9JO5GBeXISgxKcV6AdKcEVZKfQV5I%3D"