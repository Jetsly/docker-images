## jenkins
1. 设置挂载文件夹的权限
```shell
sudo chown -R 1000 jenkins
```
2. 动态获得git仓库的分支, 基于`Dynamic Parameter Plug-in`插件
```
def gettags = ("git ls-remote -h https://ip:port/xxx/xxx.git").execute()
gettags.text.readLines().collect { it.split()[1].replaceAll('refs/heads/', '')  }.unique()
```
3. 生成`ssh`
```
sudo docker exec -it 79e80e83dac1 sh
ssh-keygen -t rsa -C "diandi@in66.com"
cat ~/.ssh/id_rsa.pub 
```