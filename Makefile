# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: dmalesev <marvin@42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/06/22 10:21:38 by dmalesev          #+#    #+#              #
#    Updated: 2022/06/23 15:11:57 by dmalesev         ###   ########.fr        #
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
NAME_GI =	life_gi
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
SOURCES_LIST =	game_of_life.c\
				iterate.c\
				map.c
SOURCES = $(addprefix $(SOURCES_DIRECTORY), $(SOURCES_LIST))

SOURCES_GI_DIRECTORY = ./sources/
SOURCES_GI_LIST =	game_of_life_gi.c\
				iterate.c
SOURCES_GI = $(addprefix $(SOURCES_GI_DIRECTORY), $(SOURCES_GI_LIST))

OBJECTS_DIRECTORY = objects/
OBJECTS_LIST = $(patsubst %.c, %.o, $(SOURCES_LIST))
OBJECTS	= $(addprefix $(OBJECTS_DIRECTORY), $(OBJECTS_LIST))

OBJECTS_GI_DIRECTORY = objects_gi/
OBJECTS_GI_LIST = $(patsubst %.c, %.o, $(SOURCES_GI_LIST))
OBJECTS_GI	= $(addprefix $(OBJECTS_GI_DIRECTORY), $(OBJECTS_GI_LIST))

INCLUDES = -I$(HEADERS_DIRECTORY) -I./minilibx/

ASSERT_OBJECT = && echo "$@ $(GREEN)$(BOLD) ✔$(RESET)" || echo "$@ $(RED)$(BOLD)✘$(RESET)"
ASSERT_GI_OBJECT = && echo "$@ $(CYAN)$(BOLD) ✔$(RESET)" || echo "$@ $(RED)$(BOLD)✘$(RESET)"

all: $(NAME) $(NAME_GI)

$(NAME): $(OBJECTS_DIRECTORY) $(OBJECTS)
	@$(CC) $(FLAGS) $(INCLUDES) $(OBJECTS) -o $(NAME)
	@echo "Compiled $(BOLD)$(NAME)$(RESET)!\n"

$(NAME_GI): $(OBJECTS_GI_DIRECTORY) $(OBJECTS_GI)
	@$(CC) $(FLAGS) $(LIBS) $(INCLUDES) $(OBJECTS_GI) -o $(NAME_GI)
	@echo "Compiled $(BOLD)$(NAME_GI)$(RESET)!\n"

$(OBJECTS_GI_DIRECTORY):
	@mkdir -p $(OBJECTS_GI_DIRECTORY)
	@echo "$(NAME): $(GREEN)$(OBJECTS_GI_DIRECTORY) was created$(RESET)"

$(OBJECTS_DIRECTORY):
	@mkdir -p $(OBJECTS_DIRECTORY)
	@echo "$(NAME): $(GREEN)$(OBJECTS_DIRECTORY) was created$(RESET)"

$(OBJECTS_GI_DIRECTORY)%.o : $(SOURCES_GI_DIRECTORY)%.c $(HEADERS)
	@$(CC) $(FLAGS) -c $(INCLUDES) $< -o $@ $(ASSERT_GI_OBJECT)

$(OBJECTS_DIRECTORY)%.o : $(SOURCES_DIRECTORY)%.c $(HEADERS)
	@$(CC) $(FLAGS) -c $(INCLUDES) $< -o $@ $(ASSERT_OBJECT)

clean:
	@rm -rf $(OBJECTS_DIRECTORY)
	@rm -rf $(OBJECTS_GI_DIRECTORY)
	@echo "$(NAME): $(RED)$(OBJECTS_DIRECTORY) was deleted$(RESET)"
	@echo "$(NAME): $(RED)$(OBJECTS_GI_DIRECTORY) was deleted$(RESET)"
	@echo "$(NAME): $(RED)object files were deleted$(RESET)\n"
	@echo "$(NAME): $(RED)object_gi files were deleted$(RESET)\n"

fclean: clean
	@rm -f $(NAME)
	@echo "$(NAME): $(RED)$(NAME) was deleted$(RESET)\n"
	@rm -f $(NAME_GI)
	@echo "$(NAME_GI): $(RED)$(NAME) was deleted$(RESET)\n"

re:
	@make fclean
	@make all

_.PHONY: all clean fclean re
