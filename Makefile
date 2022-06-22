# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: dmalesev <marvin@42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/06/22 10:21:38 by dmalesev          #+#    #+#              #
#    Updated: 2022/06/22 14:19:39 by dmalesev         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#COLORS
GREEN = \033[32m
YELLOW = \033[33m
VIOLET = \033[0;35m
RESET = \033[0m
RED = \033[31m
CYAN = \033[36m
BOLD = \033[1m

NAME =		life
CC =		gcc
FLAGS =		-Wall -Wextra -Werror -Wconversion
LNX_FLAGS = -Wall -Wextra -Werror -Wconversion

UNAME = $(shell uname)
ifeq ($(UNAME), Darwin)
LIBS =	-lmlx -framework AppKit -framework OpenGL
endif
ifeq ($(UNAME), Linux)
LIBS =	-O -lmlx_Linux -lXext -lX11 -lm
endif

HEADERS_DIRECTORY = ./includes/
HEADERS_LIST =	game_of_life.h
HEADERS = $(addprefix $(HEADERS_DIRECTORY), $(HEADERS_LIST))

SOURCES_DIRECTORY = ./sources/
SOURCES_LIST =	game_of_life.c
SOURCES = $(addprefix $(SOURCES_DIRECTORY), $(SOURCES_LIST))

OBJECTS_DIRECTORY = objects/
OBJECTS_LIST = $(patsubst %.c, %.o, $(SOURCES_LIST))
OBJECTS	= $(addprefix $(OBJECTS_DIRECTORY), $(OBJECTS_LIST))

INCLUDES = -I$(HEADERS_DIRECTORY) -I./minilibx/

ASSERT_OBJECT = && echo "$@ $(GREEN)$(BOLD) ✔$(RESET)" || echo "$@ $(RED)$(BOLD)✘$(RESET)"

all: $(NAME)

$(NAME): $(OBJECTS_DIRECTORY) $(OBJECTS)
	@$(CC) $(FLAGS) $(LIBS) $(INCLUDES) $(OBJECTS) -o $(NAME)
	@echo "Compiled $(BOLD)$(NAME)$(RESET)!\n"

$(OBJECTS_DIRECTORY):
	@mkdir -p $(OBJECTS_DIRECTORY)
	@echo "$(NAME): $(YELLOW)$(OBJECTS_DIRECTORY) was created$(RESET)"

$(OBJECTS_DIRECTORY)%.o : $(SOURCES_DIRECTORY)%.c $(HEADERS)
	@$(CC) $(FLAGS) -c $(INCLUDES) $< -o $@ $(ASSERT_OBJECT)

clean:
	@rm -rf $(OBJECTS_DIRECTORY)
	@echo "$(NAME): $(RED)$(OBJECTS_DIRECTORY) was deleted$(RESET)"
	@echo "$(NAME): $(RED)object files were deleted$(RESET)\n"

fclean: clean
	@rm -f $(NAME)
	@echo "$(NAME): $(RED)$(NAME) was deleted$(RESET)\n"

re:
	@make fclean
	@make all

.PHONY: all clean fclean re
