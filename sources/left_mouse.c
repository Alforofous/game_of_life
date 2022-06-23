/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   left_mouse.c                                       :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: dmalesev <marvin@42.fr>                    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2022/05/11 13:24:07 by dmalesev          #+#    #+#             */
/*   Updated: 2022/06/23 19:56:58 by dmalesev         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "game_of_life.h"

void	translate_pixels_to_coords(t_utils *utils, int x, int y, int color, u_int8_t set)
{
	float	x_scale;
	float	y_scale;

	mlx_pixel_put(utils->mlx, utils->win, x, y, color);
	x_scale = (float)utils->line_len / (float)utils->img.dim.width;
	y_scale = (float)utils->lines / (float)utils->img.dim.height;
	x -= utils->img.dim.x0;
	y -= utils->img.dim.y0;
	x *= x_scale;
	y *= y_scale;
	utils->map[y][x] = set;
}

void	hold_left_button(t_utils *u, int x, int y)
{
	if (coords_in_img(&u->img, x, y))
		translate_pixels_to_coords(u, x, y, 0x009900, 1);
	x += 0;
	y += 0;
}

void	left_button_down(t_utils *u, int x, int y)
{
	if (coords_in_img(&u->img, x, y))
		translate_pixels_to_coords(u, x, y, 0x009900, 1);
	u->state = 0;
	x += 0;
	y += 0;
}

void	left_button_up(t_utils *u, int x, int y)
{
	if (coords_in_img(&u->img, x, y))
		translate_pixels_to_coords(u, x, y, 0x009900, 1);
	u->state = 1;
}
