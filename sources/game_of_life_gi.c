/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   game_of_life.c                                     :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: dmalesev <marvin@42.fr>                    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2022/06/22 10:27:30 by dmalesev          #+#    #+#             */
/*   Updated: 2022/06/23 15:14:38 by dmalesev         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "game_of_life.h"

static u_int8_t	**get_map(FILE *file, size_t line_len, size_t lines)
{
	size_t	i;
	size_t	j;
	char	c;
	size_t	ret;
	u_int8_t	**map;

	map = (u_int8_t **)malloc(sizeof(u_int8_t *) * lines);
	if (!map)
		return (NULL);
	i = 0;
	while (i < lines)
	{
		map[i] = (u_int8_t *)malloc(sizeof(u_int8_t) * line_len);
		if (!map[i])
			return (NULL);
		i++;
	}
	i = 0;
	while (i < lines)
	{
		j = 0;
		while (j < line_len)
		{
			ret = fread(&c, sizeof(char), 1, file);
			if (ret == 0)
				break ;
			if (c == 'x')
				map[i][j] = 1;
			else if (c == '.')
				map[i][j] = 0;
			else if (c == '\n')
				continue ;
			j++;
		}
		i++;
	}
	return (map);
}

static int	get_map_params(FILE *file, size_t *line_len, size_t *lines)
{
	size_t	file_len;
	char	*line;

	fseek(file, 0, SEEK_END);
	file_len = (size_t)ftell(file);
	fseek(file, 0, SEEK_SET);
	line = (char *)malloc(sizeof(char) * file_len);
	if (!line)
		return (-1);
	fgets(line, (int)file_len, file);
	*line_len = strlen(line);
	free(line);
	*lines = file_len / *line_len;
	(*line_len)--;
	fseek(file, 0, SEEK_SET);
	return (1);
}

static FILE	*open_file(char *path)
{
	FILE	*file;

	file = fopen(path, "r");
	return (file);
}

static void	close_prog(char *exit_msg, int exit_code)
{
	perror(exit_msg);
	exit(exit_code);
}

int	main(int argc, char **argv)
{
	FILE	*file;
	size_t	line_len;
	size_t	lines;
	u_int8_t	**map;

	if (argc != 3)
		close_prog("Usage: <filename> [iterations]\nERROR", 1);
	file = open_file(argv[1]);
	if (file == NULL)
		close_prog("ERROR", 1);
	if (get_map_params(file, &line_len, &lines) == -1)
		close_prog("ERROR", 1);
	map = get_map(file, line_len, lines);
	if (map == NULL)
		close_prog("ERROR", 1);
	iterate_map(map, line_len, lines, atol(argv[2]));
	fclose(file);
	return (0);
}
