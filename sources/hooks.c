/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   clock.c                                            :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: dmalesev <marvin@42.fr>                    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2022/05/11 17:08:09 by dmalesev          #+#    #+#             */
/*   Updated: 2022/06/23 19:32:35 by dmalesev         ###   ########.fr       */
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
	t_utils	*utils;

	utils = param;
	if (utils->tick % utils->speed == 0 && utils->state == 1)
		render_screen(utils);
	if (utils->tick == 100)
		utils->tick = 0;
	else
		utils->tick += 1;
	return (0);
}
