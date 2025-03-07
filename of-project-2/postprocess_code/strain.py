import numpy as np
import matplotlib.pyplot as plt

# Define cylinder radius
R = 0.5

# List of data files
data_files = ['piover2_UF.txt', 'piover2_UM.txt', 'piover2_UC.txt']
titles = ['Original', 'Modified', 'Corrected']

# Initialize arrays to store computed strain tensors and deltas
all_e_rr_wall = []
all_e_rtheta_wall = []
all_inv_deltas = []

for i, file in enumerate(data_files):
    # Load the data
    data = np.loadtxt(file)
    
    # Extract relevant columns
    x = data[:, 0]   # x-coordinate
    y = data[:, 1]   # y-coordinate
    u_x = data[:, 3] # x-component of velocity
    u_y = data[:, 4] # y-component of velocity
    
    # Compute the radial distance from the center
    t = np.sqrt(x**2 + y**2)
    s = t - R
    
    # Ensure only values where s > 0 are considered (outside the cylinder)
    validIndices = s >= 0
    s_valid = s[validIndices]
    
    # Compute velocity components in polar coordinates
    theta = np.arctan2(y[validIndices], x[validIndices])  # Calculate theta dynamically
    u_r = u_x * np.cos(theta) + u_y * np.sin(theta)
    u_theta = -u_x * np.sin(theta) + u_y * np.cos(theta)
    
    # Compute rate of strain tensor
    s_step = s_valid[1] - s_valid[0]  # Grid spacing
    
    # Compute derivatives using finite differences
    du_r_dr = np.gradient(u_r, s_step)
    du_theta_dr = np.gradient(u_theta, s_step)
    
    # Compute rate of strain tensor components
    e_rr = du_r_dr
    e_rtheta = 0.5 * (du_theta_dr - u_theta / s_valid)
    
    # Compute delta using consistent indices and the first two valid points
    delta = s_valid[1] - s_valid[0]  # Using the difference in radial distances
    inv_delta = 1 / delta  # Inverse delta
    
    # Store the computed strain tensors at the wall and inverse deltas
    all_e_rr_wall.append(e_rr[0])  # First value corresponds to the wall
    all_e_rtheta_wall.append(e_rtheta[0])  # First value corresponds to the wall
    all_inv_deltas.append(inv_delta)
    
    # Print delta and inverse delta for debugging
    print(f"File: {file}")
    print(f"Delta: {delta}")
    print(f"1/Delta: {inv_delta}")
    print(f"e_rr at the wall: {e_rr[0]}")
    print(f"e_rtheta at the wall: {e_rtheta[0]}")
    print()

# Normalize the inverse delta to start from 0
min_inv_delta = min(all_inv_deltas)
normalized_inv_deltas = [inv_delta - min_inv_delta for inv_delta in all_inv_deltas]

# Plot e_rr and e_rtheta at the wall on the same graph as a function of normalized 1/delta
plt.figure(figsize=(8, 6))

# Plot e_rr vs normalized 1/delta
plt.plot(normalized_inv_deltas, all_e_rr_wall, 'bo-', label='$e_{rr}$ at the wall')
# Plot e_rtheta vs normalized 1/delta
plt.plot(normalized_inv_deltas, all_e_rtheta_wall, 'ro-', label='$e_{r\\theta}$ at the wall')

# Set x-axis limits (start from 0)
plt.xlim([0, max(normalized_inv_deltas) * 1.1])

# Set uniform ticks for x-axis
ticks = np.linspace(0, max(normalized_inv_deltas), num=6)  # Create uniform ticks
plt.xticks(ticks)

# Labels and title
plt.xlabel('Normalized $1/\\delta$')
plt.ylabel('Strain Tensor Components')
plt.title('Strain Tensors at the Wall vs Normalized $1/\\delta$')

# Add legend
plt.legend()

# Add grid
plt.grid(True, which="both", ls="--")

# Save the plot as an EPS file
plt.tight_layout()
plt.savefig('strain_tensors_vs_normalized_delta.eps', format='eps')

# Show the plot
plt.show()
