# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: dmalesev <marvin@42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/11/03 09:10:41 by dmalesev          #+#    #+#              #
#    Updated: 2022/06/30 14:34:28 by dmalesev         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#COLORS
GREEN = \033[0;32m
VIOLET = \033[0;35m
RED = \033[0;31m
RESET = \033[0m
BOLD = \033[1m
CYAN = \033[36m

#PRINTING TOOLS
ERASE_LINE = \033[K
MOVE_CURSOR_UP = \033[A

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

OBJECTS_DIRECTORY = objects/
OBJECTS_LIST = $(patsubst %.c, %.o, $(SOURCES_LIST))
OBJECTS	= $(addprefix $(OBJECTS_DIRECTORY), $(OBJECTS_LIST))

INCLUDES = $(HEADERS_DIRECTORY)

ASSERT_OBJECT = && printf "$(ERASE_LINE)" && echo '$@ $(CYAN)$(BOLD) ✔$(RESET)' || echo '$@ $(RED)$(BOLD)✘$(RESET)'

all: $(NAME)

$(NAME): $(OBJECTS_DIRECTORY) $(OBJECTS)
	@ar rc $(NAME) $(OBJECTS)
	@ranlib $(NAME)
	@echo "$(NAME): $(CYAN)object files were created.$(RESET)"
	@echo "Compiled $(BOLD)$(NAME)$(RESET)!\n"

$(OBJECTS_DIRECTORY):
	@stty -echo
	@mkdir -p $(OBJECTS_DIRECTORY)
	@echo "$(NAME): $(CYAN)$(OBJECTS_DIRECTORY) directory was created.$(RESET)\n\n\n"

$(OBJECTS_DIRECTORY)%.o : $(SOURCES_DIRECTORY)%.c $(HEADERS)
	@printf "$(MOVE_CURSOR_UP)"
	@printf "$(MOVE_CURSOR_UP)"
	@$(CC) $(FLAGS) -c -I$(INCLUDES) $< -o $@ $(ASSERT_OBJECT)
	@make pbar

clean:
	@rm -rf $(OBJECTS_DIRECTORY)
	@echo "$(NAME): $(RED)$(OBJECTS_DIRECTORY) directory was deleted.$(RESET)"
	@echo "$(NAME): $(RED)object files were deleted.$(RESET)\n"

fclean: clean
	@rm -f $(NAME)
	@echo "$(NAME): $(RED)$(NAME) was deleted.$(RESET)\n"

re: fclean all

pbar:
	$(eval LOADED_COUNT = $(words $(wildcard $(OBJECTS_DIRECTORY)*.o)))
	@for ((i = 1; i <= $(LOADED_COUNT); i++)); do\
		printf "$(CYAN)█$(RESET)" ;\
	done ;
	@for ((i = 1; i <= $(SOURCE_COUNT) - $(LOADED_COUNT); i++)); do\
		printf "█" ;\
	done ;\
	printf "\n"

.PHONY: all clean fclean re
