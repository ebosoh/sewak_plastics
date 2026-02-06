from rembg import remove
from PIL import Image
import io
import os

def process_image(input_path, output_path):
    print(f"Processing {input_path}...")
    try:
        with open(input_path, 'rb') as i:
            input_data = i.read()
            # This might download the model on first run
            subject = remove(input_data)
            img = Image.open(io.BytesIO(subject)).convert("RGBA")
            
            # Create a white background
            background = Image.new('RGBA', img.size, (255, 255, 255, 255))
            # Composite
            combined = Image.alpha_composite(background, img)
            
            combined.save(output_path)
            print(f"Saved to {output_path}")
    except Exception as e:
        print(f"Error processing {input_path}: {e}")

files = [
    ("500L Loft.JPG", "500L Loft.png"),
    ("1000 Loft.jpeg", "1000 Loft.png")
]

for inp, out in files:
    if os.path.exists(inp):
        process_image(inp, out)
    else:
        print(f"File not found: {inp}")
