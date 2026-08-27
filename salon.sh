#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=salon -t --no-align -c"
echo -e "\n~~~~~ MY SALON ~~~~~\n"
LIST_SERVICES(){
  SERVICES="$($PSQL "SELECT * FROM services ORDER BY service_id")"
  echo "$SERVICES" | while IFS="|" read SERVICE_ID NAME
  do
    echo $SERVICE_ID")" $NAME
  done
}

TAKE_APPOINTMENT(){
  echo -e "\nWhat's your phone number?"
  read CUSTOMER_PHONE
  CUSTOMER_NAME="$($PSQL "SELECT name FROM customers WHERE phone = '$CUSTOMER_PHONE'")"
  if [[ -z $CUSTOMER_NAME ]]
  then
    while [[ -z $CUSTOMER_NAME ]]
    do
      echo -e "\nI don't have a record for that phone number, what's your name?"
      read CUSTOMER_NAME
    done
    ADD_CUSTOMER_RESULT="$($PSQL "INSERT INTO customers(phone, name) VALUES ('$CUSTOMER_PHONE', '$CUSTOMER_NAME')")"
  fi
  CUSTOMER_ID="$($PSQL "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE'")"
  SERVICE_NAME="$($PSQL "SELECT name FROM services WHERE service_id = $1")"
  SERVICE_TIME=""
  while [[ -z $SERVICE_TIME ]]
  do
    echo -e "\nWhat time would you like your $SERVICE_NAME, $CUSTOMER_NAME?"
    read SERVICE_TIME
  done
  ADD_APPOINTMENT_RESULT="$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES ($CUSTOMER_ID, $1, '$SERVICE_TIME')")"
  echo -e "\nI have put you down for a $SERVICE_NAME at $SERVICE_TIME, $CUSTOMER_NAME."
}

# Programma principale
MAIN_MENU(){
  if [[ -n $1 ]]
  then
    echo -e "\n$1"
  fi
  LIST_SERVICES
  read SERVICE_ID_SELECTED
  SERVICE_SELECTED="$($PSQL "SELECT * FROM services WHERE service_id = $SERVICE_ID_SELECTED")"
  if [[ -z $SERVICE_SELECTED ]]
  then
    MAIN_MENU "I could not find that service. What would you like today?"
  else
    TAKE_APPOINTMENT $SERVICE_ID_SELECTED
  fi
}

echo -e "Welcome to My Salon, how can I help you?\n"
MAIN_MENU