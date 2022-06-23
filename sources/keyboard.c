/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   keyboard.c                                         :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: dmalesev <dmalesev@student.hive.fi>        +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2022/03/28 16:01:42 by dmalesev          #+#    #+#             */
/*   Updated: 2022/06/23 20:50:19 by dmalesev         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "game_of_life.h"

static void	reset_map(u_int8_t **map, size_t lines, size_t line_len)
{
	size_t	i;
	size_t	j;

	i = 0;
	while (i < lines)
	{
		j = 0;
		while (j < line_len)
		{
			map[i][j] = 0;
			j++;
		}
		i++;
	}
}

int	key_down(int key, void *param)
{
	t_utils	*utils;

	utils = param;
	if (key == ESC)
		close_prog(utils, "Exited program succesfully using ESC.", 1);
	if (key == SPACE)
		reset_map(utils->map, utils->lines, utils->line_len);
	render_screen(utils);
	return (0);
}
