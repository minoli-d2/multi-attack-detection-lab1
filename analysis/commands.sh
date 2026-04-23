grep "Failed password" logs/attacks_log.log | awk '{print $11}' | sort | uniq -c |sort -nr

grep "185.234.219.12" logs/attacks_log.log  | awk '{print $1,$2,$3,$9,$11}'

grep "185.234.219.12" logs/attacks_log.log  | grep "Accepted"

grep "45.77.88.19" logs/attacks_log.log  | awk '{print $1,$2,$3,$9,$11}'

grep "45.77.88.19" logs/attacks_log.log  | grep "Accepted"

grep "103.56.22.90" logs/attacks_log.log  | awk '{print $1,$2,$3,$9,$11}'

grep "103.56.22.90" logs/attacks_log.log  | grep "Accepted"

grep "66.23.11.45" logs/attacks_log.log  | awk '{print $1,$2,$3,$9,$11}'

grep "66.23.11.45" logs/attacks_log.log | grep "Accepted"

grep "Accepted" logs/attacks_log.log | awk '{print $1,$2,$3,$9,$11}'

grep "sudo" logs/attacks_log.log

grep "bob" logs/attacks_log.log

grep "charlie" logs/attacks_log.log

grep "david" logs/attacks_log.log

grep "eve" logs/attacks_log.log
