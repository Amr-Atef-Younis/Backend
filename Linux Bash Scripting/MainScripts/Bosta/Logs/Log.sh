#!/bin/bash

script_path="$BOSTA_DIRECTORY/My_Scripts/Logs/"
logTypesFile="Types.txt"
enviromentsFile="Enviroments.txt"
durationsFile="Durations.txt"

getLogType () {
logType=$(zenity --list --text="Directories" --column="Select" --column="Data" --radiolist $(awk '{print ""$0""}' "$script_path$logTypesFile") --width=300 --height=400)
case "$logType" in
	"forget-password")
		email=$(zenity --entry --text="Enter email address to search with")
		secondPart="%0AhttpRequest.requestUrl%3D%22http:%2F%2Fapp.bosta.co%2Fapi%2Fv2%2Fusers%2Fforget-password%22%0AjsonPayload.req.body.email%3D%22$email%22"
		url="$firstPart$secondPart"
		;;
	"login")
		email=$(zenity --entry --text="Enter email address to search with")
		secondPart="%0A%0A%0AhttpRequest.requestUrl%3D%22http:%2F%2Fapp.bosta.co%2Fapi%2Fv2%2Fusers%2Flogin%22%0AjsonPayload.req.body.email%3D%22$email%22"
		url="$firstPart$secondPart"
		;;
	"remove-team-member")
		email=$(zenity --entry --text="Enter email address of the deleting member")
		secondPart="%0A%0A%0A%0AhttpRequest.requestUrl%3D~%22http:%2F%2Fapp.bosta.co%2Fapi%2Fv2%2Fusers%2Fbusiness%2Fadmin%2F%22%0AjsonPayload.user.emails.address%3D%22$email%22"
		url="$firstPart$secondPart"
		;;
	"add-bank-info")
		businessId=$(zenity --entry --text="Enter business ID to search with")
		secondPart="%0A%0A%0AhttpRequest.requestUrl%3D%22http:%2F%2Fapp.bosta.co%2Fapi%2Fv2%2Fbusinesses%2Fadd-bank-info%22%0AjsonPayload.user.businessAdminInfo.businessId%3D%22$businessId%22"
		url="$firstPart$secondPart"
		;;
	"generate-payment-otp")
		businessId=$(zenity --entry --text="Enter business ID to search with")
		secondPart="%0A%0A%0AhttpRequest.requestUrl%3D%22http:%2F%2Fapp.bosta.co%2Fapi%2Fv2%2Fbusinesses%2F$businessId%2Fgenerate-payment-otp%22%0A"
		url="$firstPart$secondPart"
		;;
	"generate-personal-otp")
		businessId=$(zenity --entry --text="Enter business ID to search with")
		secondPart="%0A%0A%0AhttpRequest.requestUrl%3D%22http:%2F%2Fapp.bosta.co%2Fapi%2Fv2%2Fusers%2Fgenerate-personal-otp%22%0AjsonPayload.user.businessAdminInfo.businessId%3D%22$businessId%22%0A"
		url="$firstPart$secondPart"
		;;
	"sms")
		phoneNumber=$(zenity --entry --text="Enter phone number to search with")
		url="https://console.cloud.google.com/logs/query;query=resource.type%3D%22k8s_container%22%0Aresource.labels.project_id%3D%22bosta-new-infrastructure%22%0Aresource.labels.location%3D%22europe-west3%22%0Aresource.labels.cluster_name%3D%22bosta-app-private-cluster-1%22%0Aresource.labels.namespace_name%3D%22default%22%0Aresource.labels.container_name%3D%22communication-service%22%0A%5Bsms%2Fvodafone.js%5D%20to%20%5B%2B$phoneNumber%0A--%20%5Bsms%2Fdeewan.js%5D%20to%20%5B%2B"
		;;
	"security")
		emailAddress="$(zenity --entry --text="email address")"
		url="https://console.cloud.google.com/logs/query;query=resource.type%3D%22k8s_container%22%0Aresource.labels.project_id%3D%22bosta-new-infrastructure%22%0Aresource.labels.location%3D%22europe-west3%22%0Aresource.labels.cluster_name%3D%22bosta-app-private-cluster-1%22%0Aresource.labels.namespace_name%3D%22default%22%0Alabels.k8s-pod%2Fapp%3D%22bosta-app%22%20severity%3E%3DDEFAULT%0A%0A%0A%0A%2528%2528%20httpRequest.requestUrl%3D%22http:%2F%2Fapp.bosta.co%2Fapi%2Fv2%2Fusers%2Flogin%22%2529%20AND%0AjsonPayload.req.body.email%3D%22$emailAddress%22%2529%20OR%0A%0A%2528%2528httpRequest.requestUrl%3D%22http:%2F%2Fapp.bosta.co%2Fapi%2Fv2%2Fusers%2Fgenerate-personal-otp%22%20OR%20%0AhttpRequest.requestUrl%3D~%22http:%2F%2Fapp.bosta.co%2Fapi%2Fv2%2Fbusinesses%2F%5Cw%2B%2Fgenerate-payment-otp%22%20OR%0AhttpRequest.requestUrl%3D%22http:%2F%2Fapp.bosta.co%2Fapi%2Fv2%2Fbusinesses%2Fadd-bank-info%22%20OR%0AhttpRequest.requestUrl%3D~%22http:%2F%2Fapp.bosta.co%2Fapi%2Fv2%2Fusers%2Fbusiness%2Fadmin%2F%22%20OR%0A%2528httpRequest.requestUrl%3D~%22http:%2F%2Fapp.bosta.co%2Fapi%2Fv2%2Fdeliveries%2Fbusiness%2F%5Cw%2B%22%20AND%20httpRequest.requestMethod%3D%22PUT%22%20AND%20jsonPayload.req.body.cod.amount%3D%220%22%2529%2529%20AND%20jsonPayload.user.emails.address%3D%22$emailAddress%22%2529;summaryFields=httpRequest%252FremoteIp,httpRequest%252FuserAgent:false:32:beginning;"
		;;
	"else")
		keyword="$(zenity --entry --text="Keyword")"
		key="$(echo "$keyword" | sed 's!/!%2F!g')"
		secondPart="%0A%22$key%22"
		url="$firstPart$secondPart"
		;;
# 	*)
# 		key="$(zenity --entry --text="Keyword")"
# 		secondPart="%0A%22$key%22"
# 		url="$firstPart$secondPart"
# 		;;
esac
}


enviroment=$(zenity --list --text="Directories" --column="Select" --column="Data" --radiolist $(awk '{print ""$0""}' "$script_path$enviromentsFile") --width=300 --height=400)

case "$enviroment" in
	"Production")
		firstPart="https://console.cloud.google.com/logs/query;query=resource.type%3D%22k8s_container%22%0Aresource.labels.project_id%3D%22bosta-new-infrastructure%22%0Aresource.labels.location%3D%22europe-west3%22%0Aresource.labels.cluster_name%3D%22bosta-app-private-cluster-1%22%0Aresource.labels.namespace_name%3D%22default%22%0Alabels.k8s-pod%2Fapp%3D%22bosta-app%22%20severity%3E%3DDEFAULT"
		getLogType
		;;
	"Staging")
		firstPart="https://console.cloud.google.com/logs/query;query=resource.type%3D%22k8s_container%22%0Aresource.labels.cluster_name%3D%22bosta-app-private-cluster-1%22%0Aresource.labels.namespace_name%3D%22staging%22%0Alabels.k8s-pod%2Fapp%3D%22bosta-app%22%20severity%3E%3DDEFAULT"
		getLogType
		;;
	"Communications")
		phoneNumber=$(zenity --entry --text="Enter phone number to search with")
		url="https://console.cloud.google.com/logs/query;query=resource.type%3D%22k8s_container%22%0Aresource.labels.project_id%3D%22bosta-new-infrastructure%22%0Aresource.labels.location%3D%22europe-west3%22%0Aresource.labels.cluster_name%3D%22bosta-app-private-cluster-1%22%0Aresource.labels.namespace_name%3D%22default%22%0Aresource.labels.container_name%3D%22communication-service%22%0A%5Bsms%2Fvodafone.js%5D%20to%20%5B$phoneNumber%0A--%20%5Bsms%2Fdeewan.js%5D%20to%20%5B%2B"
		;;
	*)
		exit
		;;
esac


duration=$(zenity --list --text="Directories" --column="Select" --column="Data" --radiolist $(awk '{print ""$0""}' "$script_path$durationsFile") --width=300 --height=400)
number=$(zenity --entry --text="Enter duration count")

case "$duration" in
	"Day")
		metric="P""$number""D"
		;;
	"Hour")
		metric="PT"$number"H"
		;;
	"minute")
		metric="PT"$number"M"
		;;
	*)
		exit
		;;
esac

final_url="$url;duration=$metric?project=bosta-new-infrastructure"

echo $final_url

/usr/share/iron/chrome-wrapper --profile-directory='Profile 1' --new-window "$final_url" &


# key="$(zenity --entry --text="Keyword")"
# lookFor="%0A%22$key%22"
# if [ ! -z "$key" ];
# then
# temp="$(echo $url$lookFor)"
# else
# temp=$url
# fi

# wm_pid=$(wmctrl -xlp | grep -i "\.Brave-browser"| cut -d' ' -f4)

# if [ -z "$wm_pid" ];
# then
# bash $BOSTA_DIRECTORY/My_Scripts/Logs/minimize_logs.sh
# fi

# brave-browser "$final_url" &

