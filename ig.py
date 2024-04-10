from PIL import Image
import numpy as np

# Read pixel values from the text file
with open('image_r5.txt', 'r') as file:
    # Read the entire content of the file
    content = file.read()

    # Remove the first 21555 characters
    content = content[21555:]

    
    lines = content.splitlines()

    
    pixel_values = [eval(line.strip()) for line in lines]


array = np.array(pixel_values, dtype=np.uint8)


array = array.reshape(712, 712, 3)


image = Image.fromarray(array)


image.save('output_image.png')


print("Image generated from pixel values and saved as output_image.png")
