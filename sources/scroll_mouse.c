/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   scroll_mouse.c                                     :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: dmalesev <marvin@42.fr>                    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2022/05/11 15:52:22 by dmalesev          #+#    #+#             */
/*   Updated: 2022/06/23 18:44:03 by dmalesev         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "game_of_life.h"

void	scroll_wheel(t_utils *u, int x, int y)
{
	u += 0;
	x += 0;
	y += 0;
}

void	scroll_wheel_up(t_utils *u, int x, int y)
{
	if (u->speed < 100)
		u->speed += 1;
	x += 0;
	y += 0;
}

void	scroll_wheel_down(t_utils *u, int x, int y)
{
	if (u->speed > 1)
		u->speed -= 1;
	x += 0;
	y += 0;
}
