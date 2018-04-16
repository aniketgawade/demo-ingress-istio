while true; do
  curl -s http://10.84.59.27:9080/productpage?u=normal > /dev/null
  echo -n .;
  sleep 0.2
done

