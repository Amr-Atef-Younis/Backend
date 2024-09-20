#!/bin/bash

businessIds=("04Zi_BNWG" "0VZTXJQnV" "0hoi2Y-17" "-4SLPjKDI" "-BXxo134P" "-F65r9hj-" "-lgn6Lr0I" "0Ss9xZ-BG" "0b1wl-wx_" "2Jrpy9u2Bg3XooTgW")

for businessId in "${businessIds[@]}";
do
	echo "businessId=$businessId"
	curl --location 'https://stg-app.bosta.co/api/v0/businesses/disable-bank-info-update-rate' \
	--header 'Content-Type: application/json' \
	--header 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjI1ckp2NWt2aUVWcXJxRVA2QnZFNCIsInJvbGVzIjpbIlNVUEVSX0FETUlOIiwiQUNDT1VOVEFOVCJdLCJlbWFpbCI6ImFtci5hdGVmQGJvc3RhLmNvIiwiY291bnRyeSI6eyJfaWQiOiI2MGU0NDgyYzdjYjdkNGJjNDg0OWM0ZDUiLCJuYW1lIjoiRWd5cHQiLCJuYW1lQXIiOiLZhdi12LEiLCJjb2RlIjoiRUcifSwicGhvbmUiOiIrMjAxMTIyMzU1Nzk3Iiwic2Vzc2lvbklkIjoiN01hZzFhWnNsaVVBZDludjcyeWd1IiwiaWF0IjoxNzI1ODY3MDQwLCJleHAiOjE3MjU5NTM0NDB9.lQfvv1T4-WKa_KBxYW3sKMe1gA2qQlZ-jxggvb2dZXM' \
	--data '{
		"businessId": "'"$businessId"'"
	}'
done
