from PIL import Image
import os

img_path = "First Factory.png"
new_img_path = "First Factory.jpg"

try:
    if not os.path.exists(img_path):
        print(f"Error: {img_path} not found.")
        exit(1)
        
    with Image.open(img_path) as img:
        print(f"Original size: {img.size}")
        # Resize if width > 1920
        if img.width > 1920:
            ratio = 1920 / img.width
            new_height = int(img.height * ratio)
            img = img.resize((1920, new_height), Image.Resampling.LANCZOS)
            print(f"Resized to: {img.size}")
            
        rgb_im = img.convert('RGB')
        rgb_im.save(new_img_path, "JPEG", quality=75, optimize=True)
        
    print(f"Success: Converted to {new_img_path}")
    
except ImportError:
    print("Error: Pillow library not found. Please install it using 'pip install Pillow'")
except Exception as e:
    print(f"Error: {e}")
