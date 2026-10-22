##

color.test <- function(base.col, main.col, accent.col) {
  plot(
    1,
    1,
    type = 'n',
    xlim = c(0, 11),
    ylim = c(0, 11),
    xlab = "",
    ylab = "",
    axes = FALSE
  )

  base.x <- c(1, 10, 10, 1, 1)
  base.y <- c(1, 1, 4, 4, 1)

  polygon(base.x, base.y, col = base.col, border = base.col)

  main.x <- c(2, 9, 9, 2, 2)
  main.y <- c(4.1, 4.1, 10, 10, 4.1)
  polygon(main.x, main.y, col = main.col, border = main.col)

  accent.1.x <- c(1, 2, 2, 1, 1)
  accent.1.y <- c(4, 4, 8, 8, 4)
  polygon(accent.1.x, accent.1.y, col = accent.col, border = accent.col)

  accent.2.x <- c(5, 10, 10, 5, 5)
  accent.2.y <- c(4, 4, 5, 5, 4)
  polygon(accent.2.x, accent.2.y, col = accent.col, border = accent.col)

  accent.3.x <- c(2, 9, 9, 2, 2)
  accent.3.y <- c(10, 10, 11, 11, 10)
  polygon(accent.3.x, accent.3.y, col = accent.col, border = accent.col)
}

color.test("black", "black", "darkorange")

color.test("darkgrey", "blue", "red")

color.test("darkgrey", "red", "blue")

color.test("gold", "darkgreen", "blue")
