#!/bin/sh

CITY="FIRENZE"
COORDS="43.819614|11.228305"

curl 'https://www.fibercop.it/wp-content/themes/fibercop/fast-ajax.php' \
  -H 'Connection: keep-alive' \
  -H 'sec-ch-ua: " Not;A Brand";v="99", "Google Chrome";v="91", "Chromium";v="91"' \
  -H 'Accept: application/json, text/javascript, */*; q=0.01' \
  -H 'DNT: 1' \
  -H 'X-Requested-With: XMLHttpRequest' \
  -H 'sec-ch-ua-mobile: ?0' \
  -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.77 Safari/537.36' \
  -H 'Content-Type: application/x-www-form-urlencoded; charset=UTF-8' \
  -H 'Origin: https://www.fibercop.it' \
  -H 'Sec-Fetch-Site: same-origin' \
  -H 'Sec-Fetch-Mode: cors' \
  -H 'Sec-Fetch-Dest: empty' \
  -H 'Accept-Language: it-IT,it;q=0.9,en-US;q=0.8,en;q=0.7' \
  -H 'Cookie: wp-wpml_current_language=it' \
  --data-raw "action=search_neighbor_coverage&city=$CITY&coords=$COORDS" \
  --compressed | jq 'sort_by(.full_street_name) | map({full_street_name, stato_copertura})'
