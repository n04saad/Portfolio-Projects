# installing required packages
install.packages("rayshader")
install.packages("shiny")


devtools::install_github("tylermorganwall/rayrender")

libs <- c(
  "tidyverse", "R.utils",
  "httr", "sf", "stars",
  "rayshader", "raster"
)



installed_libs <- libs %in% rownames(installed.packages())
if (any(installed_libs == F)) {
  install.packages(libs[!installed_libs])
}

install.packages("rgl", type = "source", INSTALL_opts = "--force-biarch")


invisible(lapply(libs, library, character.only = T))

# Aligning the map straight

url <-
  "https://geodata-eu-central-1-kontur-public.s3.amazonaws.com/kontur_datasets/kontur_population_BD_20220630.gpkg.gz"
file_name <- "bangladesh-population.gpkg.gz"

get_population_data <- function() {
  res <- httr::GET(
    url,
    write_disk(file_name),
    progress()
  )
  
  R.utils::gunzip(file_name, remove = F)
}

get_population_data()

load_file_name <- gsub(".gz", "", file_name)

### Restricting the boundary for Bangladesh:

crsLAEA <- "+proj=laea +lat_0=23.6850 +lon_0=90.3563 +x_0=4321000 +y_0=3210000 +datum=WGS84 +units=m +no_defs"
get_population_data <- function() {
  pop_df <- sf::st_read(
    load_file_name
  ) |>
    sf::st_transform(crs = crsLAEA)
}



pop_sf <- get_population_data()

head(pop_sf)
ggplot() +
  geom_sf(
    data = pop_sf,
    color = "grey10", fill = "grey10"
  )

bb <- sf::st_bbox(pop_sf)

get_raster_size <- function() {
  height <- sf::st_distance(
    sf::st_point(c(bb[["xmin"]], bb[["ymin"]])),
    sf::st_point(c(bb[["xmin"]], bb[["ymax"]]))
  )
  width <- sf::st_distance(
    sf::st_point(c(bb[["xmin"]], bb[["ymin"]])),
    sf::st_point(c(bb[["xmax"]], bb[["ymin"]]))
  )
  
  if (height > width) {
    height_ratio <- 1
    width_ratio <- width / height
  } else {
    width_ratio <- 1
    height_ratio <- height / width
  }
  
  return(list(width_ratio, height_ratio))
}
width_ratio <- get_raster_size()[[1]]
height_ratio <- get_raster_size()[[2]]

size <- 3000
width <- round((size * width_ratio), 0)
height <- round((size * height_ratio), 0)

get_population_raster <- function() {
  pop_rast <- stars::st_rasterize(
    pop_sf |>
      dplyr::select(population, geom),
    nx = width, ny = height
  )
  
  return(pop_rast)
}

pop_rast <- get_population_raster()
plot(pop_rast)

pop_mat <- pop_rast |>
  as("Raster") |>
  rayshader::raster_to_matrix()

## Initial Color
cols <- rev(c(
  "#0b1354", "#283680",
  "#6853a9", "#c863b3"
))



texture <- grDevices::colorRampPalette(cols)(256)



pop_mat |>
  rayshader::height_shade(texture = texture) |>
  rayshader::plot_3d(
    heightmap = pop_mat,
    solid = F,
    soliddepth = 0,
    zscale = 27,
    shadowdepth = 0,
    shadow_darkness = .95,
    windowsize = c(1000, 1000),
    phi = 65,
    zoom = .65,
    theta = 0,
    background = "#FFFCF5"
  )


# Use this to adjust the view after building the window object
rayshader::render_camera(phi = 75, zoom = .87, theta = 0)

# Adding Scalebar
render_scalebar(limits=c(0, 50, 150),label_unit = " KM",position = "W", y=30,
                scale_length = c(0.5,0.8))
render_compass(position = "S")



# Saving the Image
rayshader::render_highquality(
  filename = "bd_population_2022.png",
  preview = T,
  light = T,
  lightdirection = 225,
  lightaltitude = 60,
  lightintensity = 400,
  interactive = F,
  width = width, height = height
)