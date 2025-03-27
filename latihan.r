if (!require("ggpubr")) install.packages("ggpubr", dependencies=TRUE)
if (!require("ggplot2")) install.packages("ggplot2", dependencies=TRUE)

# Load library
library(ggplot2)
library(ggpubr)

# Baca data dari file CSV (jika datanya dalam Excel, bisa diekspor dulu ke CSV)
data <- read.csv(file.choose())  # Sesuaikan nama file jika berbeda

# Loop untuk setiap kolom
for (col_name in colnames(data)) {
  # Konversi ke numeric
  values <- as.numeric(data[[col_name]])
  
  # Buat histogram
  hist_plot <- ggplot(data, aes(x = values)) +
    geom_histogram(binwidth = 5, fill = "blue", color = "black", alpha = 0.7) +
    labs(title = paste("Histogram of", col_name), x = col_name, y = "Frequency") +
    theme_minimal()

  # Buat boxplot
  box_plot <- ggplot(data, aes(y = values)) +
    geom_boxplot(fill = "red", color = "black", alpha = 0.7) +
    labs(title = paste("Boxplot of", col_name), y = col_name) +
    theme_minimal()

  # Buat QQ-plot
  qq_plot <- ggqqplot(values, title = paste("QQ-Plot of", col_name))
  
  # Simpan ke file
  ggsave(filename = paste0("plots/histogram_", col_name, ".png"), plot = hist_plot, width = 5, height = 4)
  ggsave(filename = paste0("plots/boxplot_", col_name, ".png"), plot = box_plot, width = 5, height = 4)
  ggsave(filename = paste0("plots/qqplot_", col_name, ".png"), plot = qq_plot, width = 5, height = 4)

  # Tampilkan di terminal (opsional)
  print(hist_plot)
  print(box_plot)
  print(qq_plot)
}