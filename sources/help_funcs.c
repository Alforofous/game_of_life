/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   help_funcs.c                                       :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: dmalesev <marvin@42.fr>                    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2022/05/16 11:39:40 by dmalesev          #+#    #+#             */
/*   Updated: 2022/06/23 19:27:18 by dmalesev         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "game_of_life.h"

int	coords_in_img(t_img *img, int x, int y)
{
	if (x > img->dim.x0 && x < img->dim.x1
		&& y > img->dim.y0 && y < img->dim.y1)
		return (1);
	else
		return (0);
}

int	int_to_bit(int nbr)
{
	return (1 << (nbr - 1));
}
