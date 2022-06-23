/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   iterate.c                                          :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: ahaavist <ahaavist@student.hive.fi>        +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2022/06/23 10:19:07 by dmalesev          #+#    #+#             */
/*   Updated: 2022/06/23 20:34:28 by dmalesev         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "game_of_life.h"

static void	next_free_neighbor(u_int8_t *nbr)
{
	u_int8_t	bit;

	if ((*nbr & 30) == 30)
		return ;
	bit = 2;
	while ((*nbr & bit) == bit)
		bit <<= 1;
	*nbr |= bit;
}

static void	add_neighbors(u_int8_t **map, size_t line_len, size_t lines)
{
	size_t	i;
	size_t	j;

	i = 0;
	while (i < lines)
	{
		j = 0;
		while (j < line_len)
		{
			if ((map[i][j] & 1) == 1)
			{
				if (i > 0 && j > 0)
					next_free_neighbor(&map[i - 1][j - 1]);
				if (i > 0)
					next_free_neighbor(&map[i - 1][j]);
				if (i > 0 && j < line_len - 1)
					next_free_neighbor(&map[i - 1][j + 1]);
				if (j > 0)
					next_free_neighbor(&map[i][j - 1]);
				if (j < line_len - 1)
					next_free_neighbor(&map[i][j + 1]);
				if (i < lines - 1 && j > 0)
					next_free_neighbor(&map[i + 1][j - 1]);
				if (i < lines - 1)
					next_free_neighbor(&map[i + 1][j]);
				if (i < lines - 1 && j < line_len - 1)
					next_free_neighbor(&map[i + 1][j + 1]);
			}
			j++;
		}
		i++;
	}
}

static void	next_cycle(u_int8_t **map, size_t line_len, size_t lines)
{
	size_t	i;
	size_t	j;

	i = 0;
	while (i < lines)
	{
		j = 0;
		while (j < line_len)
		{
			if ((map[i][j] & 30) == 14 || (map[i][j] & 31) == 7)
				map[i][j] = 1;
			else
				map[i][j] = 0;
			j++;
		}
		i++;
	}
}

void	iterate_map(u_int8_t **map, size_t line_len, size_t lines, long iters)
{
	long	i;
	int		result;

	result = 0;
	i = 0;
	while (i < iters)
	{
		add_neighbors(map, line_len, lines);
		next_cycle(map, line_len, lines);
		i++;
	}
}
