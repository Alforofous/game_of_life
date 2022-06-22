/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   game_of_life.c                                     :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: dmalesev <marvin@42.fr>                    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2022/06/22 10:27:30 by dmalesev          #+#    #+#             */
/*   Updated: 2022/06/22 14:20:30 by dmalesev         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "game_of_life.h"

static int	open_file(char *path)
{
	FILE	*file;
	int		ret;

	file = fopen(path, "r");
	if (file == NULL)
	{
		perror("ERROR: Couldn't load the file: ");
		return (-1);
	}
	else
	{
		ret = 1;
		fclose(file);
		return (ret);
	}
}

int	main(int argc, char **argv)
{
	if (argc != 3)
	{
		printf("Usage: <filename> [iterations]\n");
		return (-1);
	}
	open_file(argv[1]);
	return (0);
}
