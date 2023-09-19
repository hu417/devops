mkdir -p es/{data,plugins}
chmod -R 777 es/*

docker run -d --restart=always --name es \
--privileged -p 9200:92 -p 9300:9300 \
-e "ES_JAVA_OPTS=-Xms512m -Xmx512m" \
-e "discovery.type=single-node" \
-e "xpack.security.enabled=false" \
-v ./es/data:/usr/share/elasticsearch/data \
-v ./es/plugins:/usr/share/elasticsearch/plugins \
elasticsearch:8.6.0
