
docker 
docker run --cpus 1 -m 1g \
    -d --name kafka -p 9092:9092 \
    -v ./kafka/kraft-combined-logs:/tmp/kraft-combined-logs \
    kubebiz/kafka:2.13-3.5.1 \
    /bin/bash -c "kafka-storage.sh format --cluster-id AAAAAAAAAAAAAAAAAAAAAA \
    --config /opt/kafka/config/kraft/server.properties && \ 
    exec kafka-server-start.sh /opt/kafka/config/kraft/server.properties"



获取docker容器ip
docker inspect --format='{{.NetworkSettings.IPAddress}}' kafka
生产者
bin/kafka-console-producer.sh --broker-list localhost:9092 --topic test
消费者
bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --from-beginning --topic test --consumer.config config/consumer.properties

UI工具
docker pull dushixiang/kafka-map:v1.3.3
docker run -d --name kafka-map \
    --network app-tier \
    -p 9001:8080 \
    -v ./kafka-map/data:/usr/local/kafka-map/data \
    -e DEFAULT_USERNAME=admin \
    -e DEFAULT_PASSWORD=admin \
    --restart always dushixiang/kafka-map:v1.3.3
