import os
import json

# Get environment variable values or use defaults
env_file_path = os.getenv('ENV_FILE_PATH', '.env')
template_file_path = os.getenv('TEMPLATE_FILE_PATH', 'template.json')
output_file_path = 'updated_template.json'

# Read the .env file and parse environment variables
env_vars = {}
with open(env_file_path, 'r') as file:
    for line in file:
        if line.strip() and '=' in line:
            key, value = line.strip().split('=', 1)
            value = value.strip('"')  # Remove quotes from value
            env_vars[key] = value

# Convert environment variables to the required JSON format
env_json = [{"name": key, "value": value} for key, value in env_vars.items()]

# Load the template JSON file
with open(template_file_path, 'r') as file:
    template = json.load(file)

# Add the environment variables to the containerDefinitions
if 'containerDefinitions' in template:
    for container in template['containerDefinitions']:
        container['environment'] = env_json

# Save the updated JSON to a new file
with open(output_file_path, 'w') as file:
    json.dump(template, file, indent=2)

print(f"Updated template saved to {output_file_path}")
