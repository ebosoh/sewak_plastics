from PIL import Image
import os

def remove_white_background(input_path, output_path, threshold=240):
    try:
        print(f"Processing {input_path}...")
        img = Image.open(input_path).convert("RGBA")
        datas = img.getdata()

        new_data = []
        for item in datas:
            # Change all white (also shades of whites) to transparent
            if item[0] > threshold and item[1] > threshold and item[2] > threshold:
                new_data.append((255, 255, 255, 0))
            else:
                new_data.append(item)

        img.putdata(new_data)
        img.save(output_path, "PNG")
        print(f"Successfully saved transparent image to {output_path}")
    except Exception as e:
        print(f"Error processing {input_path}: {e}")

# Process the specific files
files_to_process = [
    ("500L Loft.JPG", "500L Loft.png"),
    ("1000 Loft.jpeg", "1000 Loft.png")
]

for input_file, output_file in files_to_process:
    if os.path.exists(input_file):
        remove_white_background(input_file, output_file)
    else:
        print(f"File not found: {input_file}")
