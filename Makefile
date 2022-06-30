# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mrantil <mrantil@student.hive.fi>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/06/22 10:21:38 by dmalesev          #+#    #+#              #
#    Updated: 2022/06/30 14:56:33 by dmalesev         ###   ########.fr        #
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

#PRINTING TOOLS
ERASE_LINE = \033[K
MOVE_CURSOR_UP = \033[A

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

ASSERT_SLOW_OBJECT = && printf "$(ERASE_LINE)" && echo '$@ $(YELLOW)$(BOLD) ✔$(RESET)' || echo '$@ $(RED)$(BOLD)✘$(RESET)'
ASSERT_OBJECT = && printf "$(ERASE_LINE)" && echo '$@ $(GREEN)$(BOLD) ✔$(RESET)' || echo '$@ $(RED)$(BOLD)✘$(RESET)'
ASSERT_GI_OBJECT = && printf "$(ERASE_LINE)" && echo '$@ $(VIOLET)$(BOLD) ✔$(RESET)' || echo '$@ $(RED)$(BOLD)✘$(RESET)'

all: $(NAME) $(NAME_GI)

$(NAME_GI): $(DM_2D) $(OBJECTS_GI_DIRECTORY) $(OBJECTS_GI)
	@$(CC) $(FLAGS) $(INCLUDES) $(OBJECTS_GI) $(LIBS) -o $(NAME_GI)
	@echo "Compiled $(BOLD)$(NAME_GI)$(RESET)!\n"

$(NAME): $(OBJECTS_DIRECTORY) $(OBJECTS) $(OBJECTS_DIRECTORY_SLOW) $(OBJECTS_SLOW)
	@$(CC) $(FLAGS) $(INCLUDES) $(OBJECTS) -o $(NAME)
	@echo "Compiled $(BOLD)$(NAME)$(RESET)!\n"
	@$(CC) $(FLAGS) $(INCLUDES) $(OBJECTS_SLOW) -o $(NAME_SLOW)
	@echo "Compiled $(BOLD)$(NAME_SLOW)$(RESET)!\n"

$(OBJECTS_DIRECTORY_SLOW):
	@stty -echo
	@mkdir -p $(OBJECTS_DIRECTORY_SLOW)
	@echo "$(NAME_SLOW): $(VIOLET)$(OBJECTS_DIRECTORY_SLOW) was created$(RESET)\n\n"

$(OBJECTS_GI_DIRECTORY):
	@stty -echo
	@mkdir -p $(OBJECTS_GI_DIRECTORY)
	@echo "$(NAME): $(VIOLET)$(OBJECTS_GI_DIRECTORY) was created$(RESET)\n\n"

$(OBJECTS_DIRECTORY):
	@stty -echo
	@mkdir -p $(OBJECTS_DIRECTORY)
	@echo "$(NAME): $(GREEN)$(OBJECTS_DIRECTORY) was created$(RESET)\n\n"

$(OBJECTS_DIRECTORY_SLOW)%.o : $(SOURCES_DIRECTORY)%.c $(HEADERS)
	@printf "$(MOVE_CURSOR_UP)"
	@printf "$(MOVE_CURSOR_UP)"
	@$(CC) $(FLAGS) -c $(INCLUDES) $< -o $@ $(ASSERT_SLOW_OBJECT)
	@make pbar_slow

$(OBJECTS_GI_DIRECTORY)%.o : $(SOURCES_GI_DIRECTORY)%.c $(HEADERS)
	@printf "$(MOVE_CURSOR_UP)"
	@printf "$(MOVE_CURSOR_UP)"
	@$(CC) $(FLAGS) -c $(INCLUDES) $< -o $@ $(ASSERT_GI_OBJECT)
	@make pbar_gi

$(OBJECTS_DIRECTORY)%.o : $(SOURCES_DIRECTORY)%.c $(HEADERS)
	@printf "$(MOVE_CURSOR_UP)"
	@printf "$(MOVE_CURSOR_UP)"
	@$(CC) $(FLAGS) -c $(INCLUDES) $< -o $@ $(ASSERT_OBJECT)
	@make pbar

$(DM_2D):
	@echo "$(NAME): $(CYAN)Creating $(DM_2D)...$(RESET)\n"
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

re: fclean all

pbar_slow:
	$(eval LOADED_COUNT_SLOW = $(words $(wildcard $(OBJECTS_DIRECTORY_SLOW)*.o)))
	@for ((i = 1; i <= $(LOADED_COUNT_SLOW); i++)); do\
		printf "$(YELLOW)█$(RESET)" ;\
	done ;
	@for ((i = 1; i <= $(SOURCE_COUNT_SLOW) - $(LOADED_COUNT_SLOW); i++)); do\
		printf "█" ;\
	done ;\
	printf "\n"

pbar_gi:
	$(eval LOADED_GI_COUNT = $(words $(wildcard $(OBJECTS_GI_DIRECTORY)*.o)))
	@for ((i = 1; i <= $(LOADED_GI_COUNT); i++)); do\
		printf "$(VIOLET)█$(RESET)" ;\
	done ;
	@for ((i = 1; i <= $(SOURCE_GI_COUNT) - $(LOADED_GI_COUNT); i++)); do\
		printf "█" ;\
	done ;\
	printf "\n"


pbar:
	$(eval LOADED_COUNT = $(words $(wildcard $(OBJECTS_DIRECTORY)*.o)))
	@for ((i = 1; i <= $(LOADED_COUNT); i++)); do\
		printf "$(GREEN)█$(RESET)" ;\
	done ;
	@for ((i = 1; i <= $(SOURCE_COUNT) - $(LOADED_COUNT); i++)); do\
		printf "█" ;\
	done ;\
	printf "\n"


.PHONY: all clean fclean re
