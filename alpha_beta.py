import numpy as np
from PIL import Image


image_path = "foggy_image.jpg"
image = Image.open(image_path)


pixels = image.load()


alpha_values = []
beta_values = []


for y in range(image.height):
    for x in range(image.width):
        r, g, b = pixels[x, y]

        # Calculate alpha and beta
        alpha = r - g
        beta = 0.5 * (r + g) - b

        
        alpha_values.append(alpha)
        beta_values.append(beta)

# Calculate mean and standard deviation
mean_alpha = np.mean(alpha_values)
std_alpha = np.std(alpha_values)
mean_beta = np.mean(beta_values)
std_beta = np.std(beta_values)

# Calculate CM value
cm_value = np.sqrt(std_alpha**2 + std_beta**2) + 0.3 * np.sqrt(mean_alpha**2 + mean_beta**2)


print(f"CM value: {cm_value:.2f}")
