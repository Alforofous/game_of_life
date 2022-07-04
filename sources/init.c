/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   init.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: dmalesev <marvin@42.fr>                    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2022/06/23 15:59:37 by dmalesev          #+#    #+#             */
/*   Updated: 2022/07/04 15:47:31 by dmalesev         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "game_of_life.h"

void	init_hooks(t_utils *utils)
{
	mlx_hook(utils->win, 2, 1L << 0, &key_down, utils);
	mlx_hook(utils->win, 6, 1L << 6, &mouse_move, utils);
	mlx_hook(utils->win, 5, 1L << 3, &mouse_up, utils);
	mlx_hook(utils->win, 4, 1L << 2, &mouse_down, utils);
	mlx_hook(utils->win, 17, 0, &on_destroy, utils);
	mlx_loop_hook(utils->mlx, &prog_clock, utils);
}

static void	init_values(t_utils *utils)
{
	utils->tick = 0;
	utils->state = 1;
	utils->pause = -1;
	utils->speed = 10;
	utils->elapsed_time = 0;
	clock_gettime(CLOCK_MONOTONIC, &utils->time);
}

static void	init_mouse(t_utils *utils)
{
	utils->mouse.move_x = 0;
	utils->mouse.move_y = 0;
	utils->mouse.zoom = 20;
	utils->mouse.x = SCREEN_X / 2;
	utils->mouse.y = SCREEN_Y / 2;
}

void	init(t_utils *utils)
{
	utils->mlx = NULL;
	utils->win = NULL;
	init_mouse(utils);
	init_values(utils);
}
