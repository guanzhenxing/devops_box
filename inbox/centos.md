##  yum 

### 安装网络 yum 源

```shell
# 清理缓存  
yum clean all  
# 更新YUM源  
yum makecache  
# 备份默认源  
mkdir /root/yum_back  
mv /etc/yum.repos.d/* /root/yum_back/  
# 删除默认的国外源  
rm -rf /etc/yum.repos.d/*  
# 下载阿里源的repo文件到服务器  
cd /etc/yum.repos.d/  
wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo   
wget -O /etc/yum.repos.d/CentOS-epel.repo http://mirrors.aliyun.com/repo/epel-7.repo  
# 清理缓存  
yum clean all  
# 更新YUM源  
yum makecache  
# 关闭防火墙  
systemctl stop firewalld.service  
# 禁止开机自启  
systemctl disable firewalld  
# 关闭selinux   
sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/sysconfig/selinux  
# 重启  
reboot  
# 查询启用的yum源清单，获取仓库标识  
yum repolist  
# 安装常用软件  
yum -y install vim wget net-tools telnet tree nmap sysstat lrzsz dos2unix bind-utils ntpdate
```

resolv.conf是DNS客户机配置文件，用于设置DNS服务器的IP地址及DNS域名，还包含了主机的域名搜索顺序。该文件是由域名解析器（resolver，一个根据主机名解析IP地址的库）使用的配置文件。修改方式如下：

`vim /etc/resolv.conf`，填入：
```text
nameserver 8.8.8.8  
nameserver 114.114.114.114
```

### yum 命令的用法

#### yum 查询功能
```
yum [options] [command] [package …]
 -y：默认yum需要是交互模式，-y表示自动提供yes响应
 search：搜索某个软件名或关键字
 list：列出所有yum所管理的软件包和名称
 info：同上，也类似rpm -qai
 provides：查找该命令是由软件安装生成的，类似rpm -df的功能
 repolist：列出所有可用的repo
```

#### yum 安装、升级、降级、卸载
```
yum install：后面接需要安装的软件
 reinstall：后面接需要重新安装的软件
 update：后面接需要升级到的软件
 check-update：检查可用的升级包
 downgrade：后面接需要降级到的版本
 remove：卸载软件
 erase：功能同上，卸载和软件组相关的功能
```

#### yum 组功能
```
yum grouplist：列出所有可使用的组列表
 groupinfo：后面接groupname，可用了解该group内含所有组的名称
 groupinstall：安装整组的软件
 groupremove：删除某个组的软件
```

#### 清理缓存
```
yum clean { all | package | headers }
 all：将所有的数据删除，包括元数据和软件文件
 package：将所有已下载的软件文件删除
 headers：删除所有下载的元数据文件
```

#### 构建缓存
```
yum makecache
```

## 查看服务器基本信息

### 查看当前内核系统版本信息
cat /proc/version

### 查看操作系统版本信息 (使用命令时提示 command not found, 需要安装 redhat-lsb)
lsb_release -a


## 开关防火墙
在 RHEL7 里有几种防火墙共存：
- firewalld
- iptables
- ebtables

默认是使用 firewalld 来管理 netfilter 子系统，不过底层调用的命令仍然是 iptables 等

Firewalld 与 iptables 对比更自由、更人性化

### 查看 firewalld 状态
systemctl status firewalld

### 策略启停 firewalld

#### 启动
systemctl start firewalld

#### 停止
systemctl stop firewalld

### 开机启用 / 禁用

#### 启用
systemctl enable firewalld

#### 禁用
systemctl disable firewalld

### 查看默认域中的火墙
firewall-cmd --list-all

### 启 / 停、重启一个firewalld服务

#### 启动
systemctl start firewalld.service

#### 关闭
systemctl stop firewalld.service

#### 重启一个服务
systemctl restart firewalld.service

### 显示一个firewalld服务的状态
systemctl status firewalld.service

### 是否开机自启

#### 查看服务是否开机启动
systemctl is-enabled firewalld.service

#### 查看已启动的服务列表
systemctl list-unit-files|grep enabled

#### 查看启动失败的服务列表
systemctl --failed

#### 开机自启
systemctl enable firewalld.service

#### 禁止开机自启
systemctl disable firewalld.service

### 查看端口开放情况
firewall-cmd --list-port
如果提示FirewallD is not running，说明防火墙处于关闭状态

### 防火墙开启状态下开放端口
firewall-cmd --zone=public --add-port=3334/tcp --permanent

### 重启firewall
firewall-cmd --reload

