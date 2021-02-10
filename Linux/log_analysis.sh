#!/bin/bash
sed s/INCORRECT_PASSWORD/ACCESS_DENIED/ LogA.txt > access_denied.txt
awk '{print $4, $6} updated2_combined_access_logs.txt > filtered_logs.txt
