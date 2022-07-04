/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   right_mouse.c                                      :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: dmalesev <marvin@42.fr>                    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2022/05/11 15:25:27 by dmalesev          #+#    #+#             */
/*   Updated: 2022/07/04 11:29:55 by dmalesev         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "game_of_life.h"

void	hold_right_button(t_utils *utils, int x, int y)
{
	if (coords_in_img(&utils->img, x, y))
		translate_pixels_to_coords(utils, x, y, 0);
}

void	right_button_down(t_utils *utils, int x, int y)
{
	if (coords_in_img(&utils->img, x, y))
		translate_pixels_to_coords(utils, x, y, 0);
	utils->state = 0;
}

void	right_button_up(t_utils *utils, int x, int y)
{
	if (coords_in_img(&utils->img, x, y))
		translate_pixels_to_coords(utils, x, y, 0);
	utils->state = 1;
}
