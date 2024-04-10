import cv2


image_path = "hazed1.jpeg"
image = cv2.imread(image_path, cv2.IMREAD_GRAYSCALE)

# Apply Canny edge detection
edges = cv2.Canny(image, 100, 200)


num_edges = edges.sum() // 255


print(f"Number of edges in the image: {num_edges}")
