/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   game_of_life_gi.c                                  :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: mrantil <mrantil@student.hive.fi>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2022/06/22 10:27:30 by dmalesev          #+#    #+#             */
/*   Updated: 2022/06/28 17:29:53 by mrantil          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "game_of_life.h"

static void	destroy_images(t_utils *utils, t_img *images)
{
	while (images)
	{
		mlx_destroy_image(utils->mlx, images->ptr);
		images->ptr = NULL;
		images = images->next;
	}
}

void	close_prog(t_utils *utils, char *exit_msg, int exit_code)
{
	if (utils->win && exit_code > -2)
		mlx_destroy_window(utils->mlx, utils->win);
	if (utils->img.ptr && exit_code > -2)
		destroy_images(utils, &utils->img);
	printf("%s\n",exit_msg);
	exit(exit_code);
}

static uint8_t	**get_map(FILE *file, size_t line_len, size_t lines)
{
	size_t	i;
	size_t	j;
	char	c;
	size_t	ret;
	uint8_t	**map;

	map = (uint8_t **)malloc(sizeof(uint8_t *) * lines);
	if (!map)
		return (NULL);
	i = 0;
	while (i < lines)
	{
		map[i] = (uint8_t *)malloc(sizeof(uint8_t) * line_len);
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
			if (c == 'x' || c == 'X')
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
	line = fgets(line, (int)file_len, file);
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

static void	crt_img(t_utils *utils, t_img *img, t_4i *d, void (*f)(t_utils *u))
{
	img->dim.width = d->a;
	img->dim.height = d->b;
	img->dim.x0 = d->c;
	img->dim.y0 = d->d;
	img->dim.x1 = d->c + img->dim.width;
	img->dim.y1 = d->d + img->dim.height;
	img->next = NULL;
	img->draw_func = f;
	img->ptr = mlx_new_image(utils->mlx, d->a, d->b);
	if (!img->ptr)
		close_prog(utils, "Failed to create an image...", -1);
	img->addr = mlx_get_data_addr(img->ptr, &img->bits_per_pixel,
			&img->line_length, &img->endian);
}

static void	open_screen(t_utils *utils)
{
	utils->mlx = mlx_init();
	if (!utils->mlx)
		close_prog(utils, "Failed to connect software to display...", -2);
	utils->win = mlx_new_window(utils->mlx, SCREEN_X, SCREEN_Y, "RTv1");
	if (!utils->win)
		close_prog(utils, "Failed to open window...", -2);
	crt_img(utils, &utils->img, &(t_4i){SCREEN_X, SCREEN_Y,
		0, 0}, &draw_image1);
	init_hooks(utils);
}

int	main(int argc, char **argv)
{
	FILE		*file;
	t_utils		utils;

	if (argc != 2)
		close_prog(&utils, "Usage: <filename>", -3);
	file = open_file(argv[1]);
	if (file == NULL)
		close_prog(&utils, "ERROR", -2);
	if (get_map_params(file, &utils.line_len, &utils.lines) == -1)
		close_prog(&utils, "ERROR", -2);
	utils.map = get_map(file, utils.line_len, utils.lines);
	if (utils.map == NULL)
		close_prog(&utils, "ERROR", -2);
	init(&utils);
	open_screen(&utils);
	render_screen(&utils);
	mlx_loop(utils.mlx);
	fclose(file);
	return (0);
}
