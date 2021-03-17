# Use public repos
docker build -t xo-helloworld-server . -f public.Dockerfile

# Use private repos
# ssh_prv_key=`cat ~/.ssh/id_rsa`
# ssh_pub_key=`cat ~/.ssh/id_rsa.pub`
# ssh_known_hosts=`cat ~/.ssh/known_hosts`
# ssh_authorized_keys=`cat ~/.ssh/authorized_keys`
# docker build -t xo-helloworld-server . -f private.Dockerfile \
#     --build-arg ssh_prv_key="$ssh_prv_key" \
#     --build-arg ssh_pub_key="$ssh_pub_key" \
#     --build-arg ssh_known_hosts="$ssh_known_hosts" \
#     --build-arg ssh_authorized_keys="$ssh_authorized_keys"

docker run -p 9090:9090 -p 8080:8080 xo-helloworld-server