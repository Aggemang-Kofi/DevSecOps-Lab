#!/bin/bash
# Simple script to run scans via ZAP API against Juice Shop

ZAP_URL="http://localhost:8090"
TARGET_URL="http://juice-shop:3000"

echo "Starting spider scan..."
curl "$ZAP_URL/JSON/spider/action/scan/?url=$TARGET_URL&maxChildren=5"

echo "Waiting for spider to finish..."
sleep 15

echo "Checking spider status..."
curl "$ZAP_URL/JSON/spider/view/status/?scanId=0"

echo "Starting active scan..."
curl "$ZAP_URL/JSON/ascan/action/scan/?url=$TARGET_URL"

echo "Waiting for active scan to finish..."
sleep 30

echo "Retrieving alerts..."
curl "$ZAP_URL/JSON/core/view/alerts/"

echo "Generating HTML report..."
curl "$ZAP_URL/OTHER/core/other/htmlreport/" -o zap-report.html

echo "Scan complete. Report saved as zap-report.html"

