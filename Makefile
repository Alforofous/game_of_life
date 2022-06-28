# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mrantil <mrantil@student.hive.fi>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/06/22 10:21:38 by dmalesev          #+#    #+#              #
#    Updated: 2022/06/28 15:29:09 by mrantil          ###   ########.fr        #
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
NAME_SLOW =	life_slow
NAME_GI =	life_gi
CC =		gcc
FLAGS =		-Wall -Wextra -Wconversion
FLAGS +=	-O3
FLAGS +=	-flto

LNX_FLAGS = -Wall -Wextra -Werror -Wconversion

UNAME = $(shell uname)
ifeq ($(UNAME), Darwin)
LIBS =	-lmlx -framework AppKit -framework OpenGL $(DM_2D)
endif
ifeq ($(UNAME), Linux)
LIBS =	-O -lmlx_Linux -lXext -lX11 -lm $(DM_2D)
endif

DM_2D_DIRECTORY = ./dm_2d/
DM_2D = $(DM_2D_DIRECTORY)dm_2d.a
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

SOURCES_DIRECTORY = ./sources/
SOURCES_LIST =	game_of_life.c\
				iterate_opti.c\
				map.c
SOURCES = $(addprefix $(SOURCES_DIRECTORY), $(SOURCES_LIST))

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

OBJECTS_DIRECTORY = objects/
OBJECTS_LIST = $(patsubst %.c, %.o, $(SOURCES_LIST))
OBJECTS	= $(addprefix $(OBJECTS_DIRECTORY), $(OBJECTS_LIST))

OBJECTS_DIRECTORY_SLOW = objects_slow/
OBJECTS_LIST_SLOW = $(patsubst %.c, %.o, $(SOURCES_LIST_SLOW))
OBJECTS_SLOW	= $(addprefix $(OBJECTS_DIRECTORY_SLOW), $(OBJECTS_LIST_SLOW))

OBJECTS_GI_DIRECTORY = objects_gi/
OBJECTS_GI_LIST = $(patsubst %.c, %.o, $(SOURCES_GI_LIST))
OBJECTS_GI	= $(addprefix $(OBJECTS_GI_DIRECTORY), $(OBJECTS_GI_LIST))

INCLUDES = -I$(HEADERS_DIRECTORY) -I./minilibx/ -I$(DM_2D_HEADERS)

ASSERT_OBJECT = && echo "$@ $(GREEN)$(BOLD) ✔$(RESET)" || echo "$@ $(RED)$(BOLD)✘$(RESET)"
ASSERT_GI_OBJECT = && echo "$@ $(VIOLET)$(BOLD) ✔$(RESET)" || echo "$@ $(RED)$(BOLD)✘$(RESET)"

all: $(NAME) $(NAME_GI)

$(NAME): $(OBJECTS_DIRECTORY) $(OBJECTS)
	@$(CC) $(FLAGS) $(INCLUDES) $(OBJECTS) -o $(NAME)
	@echo "Compiled $(BOLD)$(NAME)$(RESET)!\n"

$(NAME_GI): $(OBJECTS_GI_DIRECTORY) $(OBJECTS_GI) $(DM_2D)
	@$(CC) $(FLAGS) $(LIBS) $(INCLUDES) $(OBJECTS_GI) -o $(NAME_GI)
	@echo "Compiled $(BOLD)$(NAME_GI)$(RESET)!\n"

slow: $(NAME_SLOW)

$(NAME_SLOW): $(OBJECTS_DIRECTORY_SLOW) $(OBJECTS_SLOW)
	@$(CC) $(FLAGS) $(INCLUDES) $(OBJECTS_SLOW) -o $(NAME_SLOW)
	@echo "Compiled $(BOLD)$(NAME_SLOW)$(RESET)!\n"

$(OBJECTS_DIRECTORY_SLOW):
	@mkdir -p $(OBJECTS_DIRECTORY_SLOW)
	@echo "$(NAME_SLOW): $(VIOLET)$(OBJECTS_DIRECTORY_SLOW) was created$(RESET)"

$(OBJECTS_GI_DIRECTORY):
	@mkdir -p $(OBJECTS_GI_DIRECTORY)
	@echo "$(NAME): $(VIOLET)$(OBJECTS_GI_DIRECTORY) was created$(RESET)"

$(OBJECTS_DIRECTORY):
	@mkdir -p $(OBJECTS_DIRECTORY)
	@echo "$(NAME): $(GREEN)$(OBJECTS_DIRECTORY) was created$(RESET)"

$(OBJECTS_DIRECTORY_SLOW)%.o : $(SOURCES_DIRECTORY)%.c $(HEADERS)
	@$(CC) $(FLAGS) -c $(INCLUDES) $< -o $@ $(ASSERT_OBJECT)

$(OBJECTS_GI_DIRECTORY)%.o : $(SOURCES_GI_DIRECTORY)%.c $(HEADERS)
	@$(CC) $(FLAGS) -c $(INCLUDES) $< -o $@ $(ASSERT_GI_OBJECT)

$(OBJECTS_DIRECTORY)%.o : $(SOURCES_DIRECTORY)%.c $(HEADERS)
	@$(CC) $(FLAGS) -c $(INCLUDES) $< -o $@ $(ASSERT_OBJECT)

$(DM_2D):
	@echo "$(NAME): $(CYAN)Creating $(DM_2D)...$(RESET)"
	@make -C $(DM_2D_DIRECTORY)

clean:
	@rm -rf $(OBJECTS_DIRECTORY_SLOW)
	@rm -rf $(OBJECTS_DIRECTORY)
	@rm -rf $(OBJECTS_GI_DIRECTORY)
	@make -C $(DM_2D_DIRECTORY) clean
	@echo "$(NAME): $(RED)$(OBJECTS_DIRECTORY) was deleted$(RESET)"
	@echo "$(NAME_GI): $(RED)$(OBJECTS_GI_DIRECTORY) was deleted$(RESET)"
	@echo "$(NAME): $(RED)object files were deleted$(RESET)\n"
	@echo "$(NAME_SLOW): $(RED)$(OBJECTS_DIRECTORY_SLOW) was deleted$(RESET)"
	@echo "$(NAME_SLOW): $(RED)object files were deleted$(RESET)\n"
	@echo "$(NAME_GI): $(RED)object_gi files were deleted$(RESET)\n"

fclean: clean
	@rm -f $(NAME)
	@echo "$(NAME): $(RED)$(NAME) was deleted$(RESET)\n"
	@rm -f $(NAME_SLOW)
	@echo "$(NAME_SLOW): $(RED)$(NAME) was deleted$(RESET)\n"
	@rm -f $(DM_2D)
	@echo "$(NAME): $(RED)$(DM_2D) was deleted$(RESET)\n"
	@rm -f $(NAME_GI)
	@echo "$(NAME_GI): $(RED)$(NAME) was deleted$(RESET)\n"

re:
	@make fclean
	@make all

_.PHONY: all clean fclean re
