import numpy as np
from PIL import Image

# Load the image (assuming it's named "image.jpg")
image_path = "hazed1.jpeg"
image = Image.open(image_path)

# Get the pixel data
pixels = image.load()

# Initialize lists to store alpha and beta values
alpha_values = []
beta_values = []

# Iterate over each pixel
for y in range(image.height):
    for x in range(image.width):
        r, g, b = pixels[x, y]

        # Calculate alpha and beta
        alpha = r - g
        beta = 0.5 * (r + g) - b

        # Append to the lists
        alpha_values.append(alpha)
        beta_values.append(beta)

# Calculate mean and standard deviation
mean_alpha = np.mean(alpha_values)
std_alpha = np.std(alpha_values)
mean_beta = np.mean(beta_values)
std_beta = np.std(beta_values)

# Calculate CM value
cm_value = np.sqrt(std_alpha**2 + std_beta**2) + 0.3 * np.sqrt(mean_alpha**2 + mean_beta**2)

# Print the CM value
print(f"CM value: {cm_value:.2f}")
