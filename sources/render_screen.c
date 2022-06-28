/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   render_screen.c                                    :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: dmalesev <marvin@42.fr>                    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2022/06/23 16:03:53 by dmalesev          #+#    #+#             */
/*   Updated: 2022/06/27 10:39:35 by dmalesev         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "game_of_life.h"

void	render_map(t_utils *u, u_int8_t **map, size_t line_len, size_t lines)
{
	int		i[2];
	double	x_scale;
	double	y_scale;
	size_t	map_coords[2];

	i[0] = 0;
	x_scale = (double)line_len / (double)u->curr_img->dim.width;
	y_scale = (double)lines / (double)u->curr_img->dim.height;
	while (i[0] < u->curr_img->dim.height - 1)
	{
		i[1] = 0;
		while (i[1] < u->curr_img->dim.width - 1)
		{
			map_coords[0] = (size_t)((double)i[1] * x_scale);
			map_coords[1] = (size_t)((double)i[0] * y_scale);
			if (map_coords[0] < line_len - 1 && map_coords[1] < lines - 1 && (map[map_coords[1]][map_coords[0]] & 1) == 1)
				ft_pixel_put((int)i[1], (int)i[0], 0xFFFFFF,
					(void *)u->curr_img);
			i[1]++;
		}
		i[0]++;
	}
}

void	draw_image1(t_utils *utils)
{
	render_map(utils, utils->map, utils->line_len, utils->lines);
	draw_rect(&(t_pxl_func){&ft_pixel_put, (void *)utils->curr_img},
		&(t_2i){0, 0}, &(t_2i){utils->curr_img->dim.width - 1,
		utils->curr_img->dim.height - 1}, 0xFFDD45);
}

static void	image_processing(t_utils *utils, t_img *img)
{
	utils->curr_img = img;
	ft_clear_img(utils);
	img->draw_func(utils);
	mlx_put_image_to_window(utils->mlx, utils->win, img->ptr, img->dim.x0,
		img->dim.y0);
}

void	render_screen(t_utils *utils)
{
	image_processing(utils, &utils->img);
}
