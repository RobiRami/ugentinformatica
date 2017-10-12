tr -d "0-9" | tr -d " " | cut -c 1 | sort | uniq -c | sort -nr
