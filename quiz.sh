#!/usr/bin/bash

wordlist="${HOME}/wordlist"
parser="./quiz_wordparser"

if ! [ -f "${wordlist}" ]; then
  echo -ne "\e[31m!\e[0m There is no wordlist file in "
  echo    -e "\e[32m$(realpath ${wordlist})\e[0m"
  echo -ne "\e[31m!\e[0m Check the wordlist variable in "
  echo    -e "\e[32m$(realpath "${0}")\e[0m"
  echo -ne "\e[31m!\e[0m The wordlist must contain two columns: "
  echo       "the word, and it's meaning."
  echo -ne "\e[31m!\e[0m The columns must have seperated by at least "
  echo       "4 space characters."
  exit 1
fi

if ! [ -f "${parser}" ]; then
  echo -ne "\e[31m!\e[0m There is no such a parser like "
  echo    -e "\e[31m$(realpath ${parser})\e[0m"
  echo -e "\e[31m!\e[0m Did you compiled \e[32m$(realpath ${parser}.c)\e[0m ?"

  exit 1
fi

trap '' SIGHUP SIGINT SIGQUIT SIGILL SIGTRAP SIGABRT SIGBUS SIGFPE \
  SIGUSR1 SIGSEGV SIGUSR2 SIGPIPE SIGALRM SIGTERM SIGCHLD SIGCONT  \
  SIGTSTP SIGTTIN SIGTTOU

random_line=$(shuf -n 1 "${wordlist}")
random_word=$(echo "${random_line}" | awk -F' {2,}' '{printf "%s", $1}')
solution=$(echo "${random_line}" | awk -F' {2,}'  '{printf "%s", $2}')


echo ">>> ${random_word}"

# read -p "Your answer is: " user_answer
guess_count=0

while [ "${guess_count}" -lt 3 ]; do
  read -rp "Your answer: " user_answer
  ((guess_count++))
  if [ "${user_answer}" == '!' ]; then
    echo "The word has been skipped! Correct answer is: ${solution}"
    exit 1
  else
    # ${parser} "${user_answer}" "${solution}"
    # if [ "${?}" -eq 0 ]; then
    #   echo "Correct answer!"
    #   exit 0
    if ${parser} "${user_answer}" "${solution}"; then
    echo "Correct answer!"
    exit 0
    else
      echo -e "\nWrong answer! Try again."
    fi
  fi
done

echo "All of your tries were false. The correct answer is: ${solution}"
exit 1
