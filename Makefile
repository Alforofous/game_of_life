# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mrantil <mrantil@student.hive.fi>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/06/22 10:21:38 by dmalesev          #+#    #+#              #
#    Updated: 2022/07/04 15:08:50 by dmalesev         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#COLORS
SHELL := /bin/bash
GREEN = \033[32m
GREEN_BACKGROUND = \033[42m
WHITE_BACKGROUND = \033[47m
VIOLET_BACKGROUND = \033[0;45m
YELLOW_BACKGROUND = \033[0;43m
WHITE = \033[37m
YELLOW = \033[33m
BLACK = \033[30m
VIOLET = \033[35m
RESET = \033[0m
RED = \033[31m
CYAN = \033[36m
BOLD = \033[1m

#PRINTING TOOLS
ERASE_LINE = \033[K
UP = A
DOWN = B
RIGHT = C
LEFT = D
MOVE = \033[

#FORBID KEYBOARD INTERACT
$(shell stty -echo)

MAKEFLAGS += --no-print-directory
SHELL := /bin/bash

NAME =		life_opti
NAME_SLOW =	life
NAME_GI =	life_gi
CC =		gcc
FLAGS =		-Wall -Werror -Wextra -Wconversion
FLAGS +=	-O3
FLAGS +=	-flto

UNAME = $(shell uname)
ifeq ($(UNAME), Darwin)
LIBS =	-lmlx -framework AppKit -framework OpenGL $(DM_2D)
endif
ifeq ($(UNAME), Linux)
LIBS =	-O -lXext -lX11 -lm ./minilibx/libmlx.a $(DM_2D)
endif

DM_2D_NAME = dm_2d.a
DM_2D_DIRECTORY = ./dm_2d/
DM_2D = $(DM_2D_DIRECTORY)$(DM_2D_NAME)
DM_2D_HEADERS = $(DM_2D_DIRECTORY)includes/

HEADERS_DIRECTORY = ./includes/
HEADERS_LIST =	game_of_life.h\
				mac_def.h\
				lnx_def.h
HEADERS = $(addprefix $(HEADERS_DIRECTORY), $(HEADERS_LIST))

SOURCES_LIST_SLOW =	game_of_life.c\
					iterate_slow.c\
					map.c
SOURCES_SLOW = $(addprefix $(SOURCES_DIRECTORY), $(SOURCES_LIST_SLOW))
SOURCE_COUNT_SLOW = $(words $(SOURCES_LIST_SLOW))

SOURCES_DIRECTORY = ./sources/
SOURCES_LIST =	game_of_life.c\
				iterate_opti.c\
				map.c
SOURCES = $(addprefix $(SOURCES_DIRECTORY), $(SOURCES_LIST))
SOURCE_COUNT = $(words $(SOURCES_LIST))

SOURCES_GI_DIRECTORY = ./sources/
SOURCES_GI_LIST =	game_of_life_gi.c\
					iterate_gi.c\
					init.c\
					render_screen.c\
					put_pixel.c\
					keyboard.c\
					mouse.c\
					left_mouse.c\
					right_mouse.c\
					help_funcs.c\
					scroll_mouse.c\
					hooks.c\
					map.c
SOURCES_GI = $(addprefix $(SOURCES_GI_DIRECTORY), $(SOURCES_GI_LIST))
SOURCE_GI_COUNT = $(words $(SOURCES_GI_LIST))

OBJECTS_DIRECTORY = objects_opti/
OBJECTS_LIST = $(patsubst %.c, %.o, $(SOURCES_LIST))
OBJECTS	= $(addprefix $(OBJECTS_DIRECTORY), $(OBJECTS_LIST))

OBJECTS_DIRECTORY_SLOW = objects/
OBJECTS_LIST_SLOW = $(patsubst %.c, %.o, $(SOURCES_LIST_SLOW))
OBJECTS_SLOW	= $(addprefix $(OBJECTS_DIRECTORY_SLOW), $(OBJECTS_LIST_SLOW))

OBJECTS_GI_DIRECTORY = objects_gi/
OBJECTS_GI_LIST = $(patsubst %.c, %.o, $(SOURCES_GI_LIST))
OBJECTS_GI	= $(addprefix $(OBJECTS_GI_DIRECTORY), $(OBJECTS_GI_LIST))

INCLUDES = -I$(HEADERS_DIRECTORY) -I./minilibx/ -I$(DM_2D_HEADERS)

ASSERT_SLOW_OBJECT = && printf "$(ERASE_LINE)" && printf "$@ $(YELLOW)$(BOLD) ✔$(RESET)" || printf "$@ $(RED)$(BOLD)✘$(RESET)\n\n"
ASSERT_OBJECT = && printf "$(ERASE_LINE)" && printf "$@ $(GREEN)$(BOLD) ✔$(RESET)" || printf "$@ $(RED)$(BOLD)✘$(RESET)\n\n"
ASSERT_GI_OBJECT = && printf "$(ERASE_LINE)" && printf "$@ $(VIOLET)$(BOLD) ✔$(RESET)" || printf "$@ $(RED)$(BOLD)✘$(RESET)\n\n"

all: $(NAME_SLOW) $(NAME) $(NAME_GI)

$(NAME_GI): $(DM_2D) $(OBJECTS_GI_DIRECTORY) $(OBJECTS_GI)
	@$(CC) $(FLAGS) $(INCLUDES) $(OBJECTS_GI) $(LIBS) -o $(NAME_GI)
	@printf "Compiled $(BOLD)$(VIOLET)$(NAME_GI)$(RESET)!\n\n"

$(NAME): $(DM_2D) $(OBJECTS_DIRECTORY) $(OBJECTS)
	@$(CC) $(FLAGS) $(INCLUDES) $(OBJECTS) -o $(NAME)
	@printf "Compiled $(BOLD)$(GREEN)$(NAME)$(RESET)!\n\n"

$(NAME_SLOW): $(DM_2D) $(OBJECTS_DIRECTORY_SLOW) $(OBJECTS_SLOW)
	@$(CC) $(FLAGS) $(INCLUDES) $(OBJECTS_SLOW) -o $(NAME_SLOW)
	@printf "Compiled $(BOLD)$(YELLOW)$(NAME_SLOW)$(RESET)!\n\n"

$(OBJECTS_DIRECTORY_SLOW):
	@mkdir -p $(OBJECTS_DIRECTORY_SLOW)
	@printf "$(YELLOW)_________________________________________________________________\n$(RESET)"
	@printf "$(NAME_SLOW): $(YELLOW)$(OBJECTS_DIRECTORY_SLOW) directory was created.$(RESET)\n\n\n"

$(OBJECTS_GI_DIRECTORY):
	@mkdir -p $(OBJECTS_GI_DIRECTORY)
	@printf "$(VIOLET)_________________________________________________________________\n$(RESET)"
	@printf "$(NAME_GI): $(VIOLET)$(OBJECTS_GI_DIRECTORY) directory was created.$(RESET)\n\n\n"

$(OBJECTS_DIRECTORY):
	@mkdir -p $(OBJECTS_DIRECTORY)
	@printf "$(GREEN)_________________________________________________________________\n$(RESET)"
	@printf "$(NAME): $(GREEN)$(OBJECTS_DIRECTORY) directory was created.$(RESET)\n\n\n"

$(OBJECTS_DIRECTORY_SLOW)%.o : $(SOURCES_DIRECTORY)%.c $(HEADERS)
	@printf "$(MOVE)2$(UP)"
	@$(CC) $(FLAGS) -c $(INCLUDES) $< -o $@ $(ASSERT_SLOW_OBJECT)
	@make pbar_slow

$(OBJECTS_GI_DIRECTORY)%.o : $(SOURCES_GI_DIRECTORY)%.c $(HEADERS)
	@printf "$(MOVE)2$(UP)"
	@$(CC) $(FLAGS) -c $(INCLUDES) $< -o $@ $(ASSERT_GI_OBJECT)
	@make pbar_gi

$(OBJECTS_DIRECTORY)%.o : $(SOURCES_DIRECTORY)%.c $(HEADERS)
	@printf "$(MOVE)2$(UP)"
	@$(CC) $(FLAGS) -c $(INCLUDES) $< -o $@ $(ASSERT_OBJECT)
	@make pbar

$(DM_2D):
	@make -C $(DM_2D_DIRECTORY)

clean:
	@printf "$(BOLD)Directories deleted:$(RESET)\n"
	@rm -rf $(OBJECTS_DIRECTORY_SLOW)
	@rm -rf $(OBJECTS_DIRECTORY)
	@rm -rf $(OBJECTS_GI_DIRECTORY)
	@printf "$(NAME_SLOW): \r$(MOVE)20$(RIGHT)$(BOLD)$(YELLOW)$(OBJECTS_DIRECTORY_SLOW)$(RESET)\n"
	@printf "$(NAME): \r$(MOVE)20$(RIGHT)$(BOLD)$(GREEN)$(OBJECTS_DIRECTORY)$(RESET)\n"
	@printf "$(NAME_GI): \r$(MOVE)20$(RIGHT)$(BOLD)$(VIOLET)$(OBJECTS_GI_DIRECTORY)$(RESET)\n"
	@make -C $(DM_2D_DIRECTORY) clean
	@printf "\n"

fclean: clean
	@printf "$(BOLD)Binaries deleted:$(RESET)\n"
	@rm -f $(NAME_SLOW)
	@printf "$(NAME_SLOW): \r$(MOVE)20$(RIGHT)$(BOLD)$(YELLOW)$(NAME_SLOW)$(RESET)\n"
	@rm -f $(NAME)
	@printf "$(NAME): \r$(MOVE)20$(RIGHT)$(BOLD)$(GREEN)$(NAME)$(RESET)\n"
	@rm -f $(NAME_GI)
	@printf "$(NAME_GI): \r$(MOVE)20$(RIGHT)$(BOLD)$(VIOLET)$(NAME_GI)$(RESET)\n"
	@rm -f $(DM_2D)
	@printf "$(DM_2D_NAME): \r$(MOVE)20$(RIGHT)$(BOLD)$(CYAN)$(DM_2D_NAME)$(RESET)\n"
	@printf "\n"

re: fclean all

pbar_slow:
	$(eval LOADED_COUNT_SLOW = $(words $(wildcard $(OBJECTS_DIRECTORY_SLOW)*.o)))
	@printf "\r$(MOVE)76$(RIGHT)Files compiled [$(BOLD)$(YELLOW)$(LOADED_COUNT_SLOW)$(RESET) / $(BOLD)$(YELLOW)$(SOURCE_COUNT_SLOW)$(RESET)]\n"
	@for ((i = 1; i <= $(LOADED_COUNT_SLOW) * 100 / $(SOURCE_COUNT_SLOW); i++)); do\
		printf "$(YELLOW_BACKGROUND) $(RESET)" ;\
	done ;
	@for ((i = 1; i <= 100 - ($(LOADED_COUNT_SLOW) * 100 / $(SOURCE_COUNT_SLOW)); i++)); do\
		printf "$(WHITE_BACKGROUND) $(RESET)" ;\
	done ;
	@printf "$(YELLOW_BACKGROUND)$(BOLD)$(WHITE)$(MOVE)55$(LEFT)[$$(($(LOADED_COUNT_SLOW) * 100 / $(SOURCE_COUNT_SLOW))).$$(($(LOADED_COUNT_SLOW) * 1000 / $(SOURCE_COUNT_SLOW) % 10))%%]$(MOVE)54$(RIGHT)$(RESET)\n"

pbar_gi:
	$(eval LOADED_GI_COUNT = $(words $(wildcard $(OBJECTS_GI_DIRECTORY)*.o)))
	@printf "\r$(MOVE)76$(RIGHT)Files compiled [$(BOLD)$(VIOLET)$(LOADED_GI_COUNT)$(RESET) / $(BOLD)$(VIOLET)$(SOURCE_GI_COUNT)$(RESET)]\n"
	@for ((i = 1; i <= $(LOADED_GI_COUNT) * 100 / $(SOURCE_GI_COUNT); i++)); do\
		printf "$(VIOLET_BACKGROUND) $(RESET)" ;\
	done ;
	@for ((i = 1; i <= 100 - ($(LOADED_GI_COUNT) * 100 / $(SOURCE_GI_COUNT)); i++)); do\
		printf "$(WHITE_BACKGROUND)$(VIOLET) $(RESET)" ;\
	done ;
	@printf "$(VIOLET_BACKGROUND)$(BOLD)$(WHITE)$(MOVE)55$(LEFT)[$$(($(LOADED_GI_COUNT) * 100 / $(SOURCE_GI_COUNT))).$$(($(LOADED_GI_COUNT) * 1000 / $(SOURCE_GI_COUNT) % 10))%%]$(MOVE)54$(RIGHT)$(RESET)\n"

pbar:
	$(eval LOADED_COUNT = $(words $(wildcard $(OBJECTS_DIRECTORY)*.o)))
	@printf "\r$(MOVE)76$(RIGHT)Files compiled [$(BOLD)$(GREEN)$(LOADED_COUNT)$(RESET) / $(BOLD)$(GREEN)$(SOURCE_COUNT)$(RESET)]\n"
	@for ((i = 1; i <= $(LOADED_COUNT) * 100 / $(SOURCE_COUNT); i++)); do\
		printf "$(GREEN_BACKGROUND) $(RESET)" ;\
	done ;
	@for ((i = 1; i <= 100 - ($(LOADED_COUNT) * 100 / $(SOURCE_COUNT)); i++)); do\
		printf "$(WHITE_BACKGROUND) $(RESET)" ;\
	done ;
	@printf "$(GREEN_BACKGROUND)$(BOLD)$(WHITE)$(MOVE)55$(LEFT)[$$(($(LOADED_COUNT) * 100 / $(SOURCE_COUNT))).$$(($(LOADED_COUNT) * 1000 / $(SOURCE_COUNT) % 10))%%]$(MOVE)54$(RIGHT)$(RESET)\n"

.PHONY: all clean fclean re

#ALLOW KEYBOARD INTERACT
$(shell stty echo)
