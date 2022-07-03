# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mrantil <mrantil@student.hive.fi>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/11/03 09:10:41 by dmalesev          #+#    #+#              #
#    Updated: 2022/07/03 15:47:21 by mrantil          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#COLORS
GREEN_BACKGROUND = \033[42m
WHITE_BACKGROUND = \033[47m
VIOLET_BACKGROUND = \033[0;45m
YELLOW_BACKGROUND = \033[0;43m
CYAN_BACKGROUND = \033[0;46m
GREEN = \033[0;32m
VIOLET = \033[0;35m
RED = \033[0;31m
RESET = \033[0m
BOLD = \033[1m
CYAN = \033[36m

#PRINTING TOOLS
ERASE_LINE = \033[K
UP = A
DOWN = B
RIGHT = C
LEFT = D
MOVE = \033[

SHELL := /bin/bash
MAKEFLAGS += --no-print-directory
NAME = dm_2d.a
GCC_FLAGS = -Wall -Wextra -Werror -Wconversion
CC = gcc

HEADERS_DIRECTORY = ./includes/
HEADERS_LIST =	dm_2d.h\
HEADERS = $(addprefix $(HEADERS_DIRECTORY), $(HEADERS_LIST))

SOURCES_DIRECTORY = ./sources/
SOURCES_LIST =	draw_line.c\
				draw_circle.c\
				draw_square.c\
				draw_rect.c\
				draw_quadril.c\
				draw_rectf.c\
				draw_trif.c\
				color_mix.c\
				combine_rgb.c\
				seperate_rgb.c\
				abs.c
SOURCES = $(addprefix $(SOURCES_DIRECTORY), $(SOURCES_LIST))
SOURCE_COUNT = $(words $(SOURCES_LIST))

OBJECTS_DIRECTORY = objects/
OBJECTS_LIST = $(patsubst %.c, %.o, $(SOURCES_LIST))
OBJECTS	= $(addprefix $(OBJECTS_DIRECTORY), $(OBJECTS_LIST))

INCLUDES = $(HEADERS_DIRECTORY)

ASSERT_OBJECT = && printf "$(ERASE_LINE)" && printf '$@ $(CYAN)$(BOLD) ✔$(RESET)' || printf '$@ $(RED)$(BOLD)✘$(RESET)\n'

all: $(NAME)

$(NAME): $(OBJECTS_DIRECTORY) $(OBJECTS)
	@ar rc $(NAME) $(OBJECTS)
	@ranlib $(NAME)
	@printf "Compiled $(BOLD)$(NAME)$(RESET)!\n\n"
	@stty echo

$(OBJECTS_DIRECTORY):
	@stty -echo
	@mkdir -p $(OBJECTS_DIRECTORY)
	@printf "$(CYAN)_________________________________________________________________\n$(RESET)"
	@printf "$(NAME): $(CYAN)$(OBJECTS_DIRECTORY) directory was created.$(RESET)\n\n\n"

$(OBJECTS_DIRECTORY)%.o : $(SOURCES_DIRECTORY)%.c $(HEADERS)
	@printf "$(MOVE)2$(UP)"
	@$(CC) $(FLAGS) -c -I$(INCLUDES) $< -o $@ $(ASSERT_OBJECT)
	@make pbar

clean:
	@rm -rf $(OBJECTS_DIRECTORY)
	@printf "dm_2d: $(RED)$(OBJECTS_DIRECTORY) and object files were deleted.$(RESET)\n"

fclean: clean
	@rm -f $(NAME)
	@printf "$(NAME): $(RED)$(NAME) was deleted.$(RESET)\n\n"

re: fclean all

pbar:
	$(eval LOADED_COUNT = $(words $(wildcard $(OBJECTS_DIRECTORY)*.o)))
	@printf "\r$(MOVE)76$(RIGHT)Files compiled [$(BOLD)$(CYAN)$(LOADED_COUNT)$(RESET) / $(BOLD)$(CYAN)$(SOURCE_COUNT)$(RESET)]\n"
	@for ((i = 1; i <= $(LOADED_COUNT) * 100 / $(SOURCE_COUNT); i++)); do\
		printf "$(CYAN_BACKGROUND) $(RESET)" ;\
	done ;
	@for ((i = 1; i <= 100 - ($(LOADED_COUNT) * 100 / $(SOURCE_COUNT)); i++)); do\
		printf "$(WHITE_BACKGROUND) $(RESET)" ;\
	done ;
	@printf "$(CYAN_BACKGROUND)$(BOLD)$(WHITE)$(MOVE)54$(LEFT)[$$(($(LOADED_COUNT) * 100 / $(SOURCE_COUNT)))%%]$(MOVE)54$(RIGHT)$(RESET)\n"

.PHONY: all clean fclean re
