/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   game_of_life.h                                     :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: mrantil <mrantil@student.hive.fi>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2022/06/22 10:26:30 by dmalesev          #+#    #+#             */
/*   Updated: 2022/06/27 23:07:42 by mrantil          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef GAME_OF_LIFE_H
# define GAME_OF_LIFE_H

# include "mlx.h"
# include "../dm_2d/includes/dm_2d.h"
# include <stdio.h>
# include <string.h>
# include <stdlib.h>
# define SCREEN_X 2560
# define SCREEN_Y 1440

# if __APPLE__
#  include "mac_def.h"
# elif __linux__
#  include "lnx_def.h"
# endif

typedef struct s_dim
{
	int	x0;
	int	y0;
	int	x1;
	int	y1;
	int	width;
	int	height;
}				t_dim;

typedef struct s_utils	t_utils;

typedef struct s_img
{
	void			*ptr;
	char			*addr;
	int				bits_per_pixel;
	int				line_length;
	int				endian;
	t_dim			dim;
	struct s_img	*next;
	void			(*draw_func)(t_utils *utils);
}				t_img;

typedef struct s_mouse
{
	int			button;
	int			move_x;
	int			move_y;
	int			zoom_x;
	int			zoom_y;
	int			x;
	int			y;
	int			zoom;
}				t_mouse;

typedef struct s_utils
{
	void		*mlx;
	void		*win;
	int			tick;
	int			speed;
	int			state;
	int			slider_button;
	u_int8_t	**map;
	size_t		line_len;
	size_t		lines;
	t_mouse		mouse;
	t_img		img;
	t_img		img2;
	t_img		*curr_img;
}				t_utils;

typedef struct s_4i
{
	int	a;
	int	b;
	int	c;
	int	d;
}				t_4i;

/*GOL functions*/
void	print_map(u_int8_t **map, size_t line_len, size_t lines);
void	iterate_map(u_int8_t **map, size_t line_len, size_t lines, long iters);
void	iterate_gi_map(u_int8_t **map, size_t line_len, size_t lines);
void	close_prog(t_utils *utils, char *exit_msg, int exit_code);
/*Mlx draw image functions*/
void	draw_image1(t_utils *utils);
void	draw_image2(t_utils *utils);
/*Init mlx*/
void	init_hooks(t_utils *utils);
void	init(t_utils *utils);
void	render_screen(t_utils *utils);
/*Mouse functions*/
int		mouse_move(int x, int y, void *param);
int		mouse_up(int button, int x, int y, void *param);
int		mouse_down(int button, int x, int y, void *param);
void	left_button_up(t_utils *u, int x, int y);
void	left_button_down(t_utils *u, int x, int y);
void	hold_left_button(t_utils *u, int x, int y);
void	right_button_up(t_utils *u, int x, int y);
void	right_button_down(t_utils *u, int x, int y);
void	hold_right_button(t_utils *u, int x, int y);
void	scroll_wheel(t_utils *u, int x, int y);
void	scroll_wheel_up(t_utils *u, int x, int y);
void	scroll_wheel_down(t_utils *u, int x, int y);
/*MLX hooks*/
int		key_down(int key, void *param);
int		prog_clock(void *param);
int		on_destroy(void *param);
/*Put pixel*/
void	ft_clear_img(t_utils *utils);
void	ft_pixel_put(int x, int y, int color, void *param);
/*Help functions*/
int		int_to_bit(int nbr);
int		coords_in_img(t_img *img, int x, int y);
void	translate_pixels_to_coords(t_utils *utils, int x, int y, int color, u_int8_t set);

#endif
