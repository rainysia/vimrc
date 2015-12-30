RabbitMQ
==========
##Centos7
--------
```
#yum install erlang*
#yum install rabbitmq-server
#yum install librabbitmq librabbitmq-tools
```
##Debian8
--------
```
#apt-get install erlang* rabbitmq-server
```

--------
##Configuration

### /etc/rabbitmq/rabbitmq-env.conf
--------
Touch if not exists, add the below snippets into rabbitmq-env.conf
```
RABBITMQ_PLUGINS_DIR=/usr/lib/rabbitmq/lib/rabbitmq_server-3.3.5/plugins
RABBITMQ_NODENNAME=hyve_rabbitmq
RABBITMQ_NODE_IP_ADDRESS=192.168.85.116
RABBITMQ_NODE_PORT=5672
```

### /etc/rabbitmq/enabled_plugins
--------
Touch if not exists, add the below snippets into enabled_plugins
```
[rabbitmq_management]
```

### /etc/rabbitmq/rabbitmq.config
--------
Touch if not exists, edit the below snippets in rabbitmq.config
```
{rabbit, [
    {loopback_users, []},
    {default_user,        <<"guest">>},
    {default_pass,        <<"guest">>}
]},
{rabbitmq_management, [
    {listener, [{port, 15672}, {ip, "192.168.85.116"}]}
]},
{rabbitmq_mqtt, [
    {default_user, <<"guest">>},
    {default_pass, <<"guest">>},
    {allow_anonymous, true}
]},
```

### command
--------
Install management flow
```
sudo systemctl enable rabbitmq-server
sudo systemctl restart rabbitmq-server.service
sudo netstat -anp | grep 567
sudo rabbitmq-plugins enable rabbitmq_management
sudo rabbitmq-server --version
sudo rabbitmqctl -V | more
cd /etc/rabbitmq
wget https://raw.githubusercontent.com/rabbitmq/rabbitmq-management/rabbitmq_v3_6_0/bin/rabbitmqad
sudo chown root:root rabbitmqadmin
sudo cp rabbitmqadmin /usr/local/bin/
sudo ln -s /usr/local/bin/rabbitmqadmin /usr/bin/rabbitmqadmin
sudo ln -s /usr/bin/rabbitmqadmin /bin/rabbitmqadmin
sudo rabbitmq-plugins enable rabbitmq_management
http://192.168.85.116:15672/#/
```

### Others command
--------
http://www.rabbitmq.com/configure.html#define-environment-variables
```
rabbitmqctl add_user username password
rabbitmq set_user_tags username administrator
rabbitmqctl list_uers
rabbitmqctl delete_user username
rabbitmqctl status
rabbitmq-plugins list
```
