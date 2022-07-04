/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   hooks.c                                            :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: dmalesev <marvin@42.fr>                    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2022/05/11 17:08:09 by dmalesev          #+#    #+#             */
/*   Updated: 2022/07/04 16:03:00 by dmalesev         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "game_of_life.h"

int	on_destroy(void *param)
{
	t_utils	*utils;

	utils = param;
	close_prog(utils, "Exited program succesfully using [X]", 1);
	return (0);
}

int	prog_clock(void *param)
{
	t_utils	*		utils;
	struct timespec	new_time;

	utils = param;
	clock_gettime(CLOCK_MONOTONIC, &new_time);
	utils->elapsed_time = (new_time.tv_sec - utils->time.tv_sec) * 1000000 + (new_time.tv_nsec - utils->time.tv_nsec) / 1000;
	if (utils->elapsed_time >= 1000000 / (double)utils->speed && utils->state == 1 && utils->pause == -1)
	{
		clock_gettime(CLOCK_MONOTONIC, &utils->time);
		iterate_gi_map(utils->map, utils->line_len, utils->lines);
		render_screen(utils);
	}
	if (utils->tick == 1000)
		utils->tick = 0;
	else
		utils->tick += 1;
	return (0);
}
