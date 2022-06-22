/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   game_of_life.c                                     :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: dmalesev <marvin@42.fr>                    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2022/06/22 10:27:30 by dmalesev          #+#    #+#             */
/*   Updated: 2022/06/22 17:16:00 by dmalesev         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "game_of_life.h"

static void	print_map(uint8_t **map, size_t line_len, size_t lines)
{
	size_t	i;
	size_t	j;

	i = 0;
	while (i < lines)
	{
		j = 0;
		printf("%zu: ", i);
		while (j < line_len)
		{
			printf("[%u]", map[i][j]);
			j++;
		}
		printf("\n");
		i++;
	}
}

static int	get_map(FILE *file, uint8_t **map, size_t line_len, size_t lines)
{
	size_t	i;
	size_t	j;
	char	c;
	size_t	ret;

	map = (uint8_t **)malloc(sizeof(uint8_t *) * lines);
	if (!map)
	{
		perror("ERROR");
		exit(1);
	}
	i = 0;
	while (i < lines)
	{
		map[i] = (uint8_t *)malloc(sizeof(uint8_t) * line_len);
		if (!map[i])
		{
			perror("ERROR");
			exit(1);
		}
		i++;
	}
	i = 0;
	while (i < lines)
	{
		printf("I VALUE: %zu\n", i);
		j = 0;
		while (j < line_len)
		{
			ret = fread(&c, sizeof(char), 1, file);
			if (ret == 0)
				break;
			if (c == 'x')
				map[i][j] = 1;
			else if (c == '.')
				map[i][j] = 0;
			else if (c == '\n')
				continue;
			j++;
		}
		i++;
	}
	print_map(map, line_len, lines);
	return (1);
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
	{
		perror("ERROR");
		exit(1);
	}
	fgets(line, (int)file_len, file);
	*line_len = strlen(line);
	free(line);
	*lines = file_len / *line_len;
	(*line_len)--;
	printf("LINES: %zu, LINE_LEN: %zu\n", *lines, *line_len);
	return (1);
}

static int	open_file(char *path)
{
	uint8_t	**map;
	size_t	line_len;
	size_t	lines;
	FILE	*file;

	map = NULL;
	file = fopen(path, "r");
	if (file == NULL)
	{
		perror("ERROR");
		exit(1);
	}
	else
	{
		if (get_map_params(file, &line_len, &lines) != -1)
			get_map(file, map, line_len, lines);
		fclose(file);
	}
	return (1);
}

int	main(int argc, char **argv)
{
	if (argc != 3)
	{
		perror("Usage: <filename> [iterations]\nERROR");
		exit(1);
	}
	open_file(argv[1]);
	return (0);
}
