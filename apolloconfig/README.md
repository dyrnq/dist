# apolloconfig

## init database

create 4 `configDB` and 1 `PortalDB`

```bash
CREATE DATABASE IF NOT EXISTS ApolloConfigDB_fat DEFAULT CHARACTER SET = utf8mb4;
CREATE DATABASE IF NOT EXISTS ApolloConfigDB_uat DEFAULT CHARACTER SET = utf8mb4;
CREATE DATABASE IF NOT EXISTS ApolloConfigDB_dev DEFAULT CHARACTER SET = utf8mb4;
CREATE DATABASE IF NOT EXISTS ApolloConfigDB_prod DEFAULT CHARACTER SET = utf8mb4;
CREATE DATABASE IF NOT EXISTS ApolloPortalDB DEFAULT CHARACTER SET = utf8mb4;
```

```bash
curl -fsSL https://github.com/apolloconfig/apollo/raw/master/scripts/sql/apolloconfigdb.sql | sed "s@ApolloConfigDB@ApolloConfigDB_fat@g" > fat.sql
curl -fsSL https://github.com/apolloconfig/apollo/raw/master/scripts/sql/apolloconfigdb.sql | sed "s@ApolloConfigDB@ApolloConfigDB_uat@g" > uat.sql
curl -fsSL https://github.com/apolloconfig/apollo/raw/master/scripts/sql/apolloconfigdb.sql | sed "s@ApolloConfigDB@ApolloConfigDB_dev@g" > dev.sql
curl -fsSL https://github.com/apolloconfig/apollo/raw/master/scripts/sql/apolloconfigdb.sql | sed "s@ApolloConfigDB@ApolloConfigDB_prod@g" > prod.sql

curl -fsSL -o apolloportaldb.sql https://github.com/apolloconfig/apollo/raw/master/scripts/sql/apolloportaldb.sql
```

## external db info

```bash
host: 192.168.122.37
user: root
password: 666666
```

## install

```bash
kubectl apply -f 10-namespace.yaml

kubectl -n apolloconfig apply -f v1.9.1/apollo-service-uat/10-deployments.yaml 
kubectl -n apolloconfig apply -f v1.9.1/apollo-service-fat/10-deployments.yaml
kubectl -n apolloconfig apply -f v1.9.1/apollo-service-dev/10-deployments.yaml
kubectl -n apolloconfig apply -f v1.9.1/apollo-service-prod/10-deployments.yaml
kubectl -n apolloconfig apply -f v1.9.1/apollo-portal/10-deployments.yaml
```

```bash
kubectl get svc,pod,cm -n apolloconfig -o wide
```

## uninstall

```bash
kubectl -n apolloconfig delete -f v1.9.1/apollo-service-uat/10-deployments.yaml 
kubectl -n apolloconfig delete -f v1.9.1/apollo-service-fat/10-deployments.yaml
kubectl -n apolloconfig delete -f v1.9.1/apollo-service-dev/10-deployments.yaml
kubectl -n apolloconfig delete -f v1.9.1/apollo-service-prod/10-deployments.yaml
kubectl -n apolloconfig delete -f v1.9.1/apollo-portal/10-deployments.yaml
```

## portal default user and password

```bash
username: apollo
password: admin
```
