CC = gcc
SRCS = quiz_wordparser.c
FLAGS = -Wall -Wextra -Werror -std=c99
OUT = quiz

.PHONY: all clean re test

all: test

	$(CC) $(FLAGS) $(SRCS) -o $(basename $(SRCS))
	$(shell shc -f ./quiz.sh -o quiz; rm quiz.sh.x.c)

clean:
	@if [ -e $(basename $(SRCS)) ]; then rm -rf $(OUT) $(basename $(SRCS)); fi

re: clean all
