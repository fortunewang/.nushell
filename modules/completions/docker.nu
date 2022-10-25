def "nu-complete docker log-levels" [] {
  ["debug" "info" "warn" "error" "fatal"]
}

# A self-sufficient runtime for containers
#export extern "docker" [
#  --config:string          # Location of client config files
#  --context(-c): string    # Name of the context to use to connect to the daemon
#  --debug(-D)              # Enable debug mode
#  --host(-H): string       #  Daemon socket(s) to connect to
#  --log-level(-l): string@"nu-complete docker log-levels"   # Set the logging level (default "info")
#  --tls                    # Use TLS; implied by --tlsverify
#  --tlscacert: string      # Trust certs signed only by this CA
#  --tlscert: string        # Path to TLS certificate file
#  --tlskey: string         # Path to TLS key file
#  --tlsverify              # Use TLS and verify the remote
#  --version(-v)            # Print version information and quit
#  --help(-h)
#  command?: string
#]

def "nu-complete docker image commands" [] {
  ["build" "history" "import" "inspect" "load" "list" "ls" "prune" "pull" "push" "remove" "rm" "rmi" "save" "tag"]
}

# Manage images
export extern "docker image" [
  --help(-h)
  command?: string@"nu-complete docker image commands"
]

# Build an image from a Dockerfile
export extern "docker image build" [
  --add-host: string            # Add a custom host-to-IP mapping (host:ip)
  --build-arg: string           # Set build-time variables
  --cache-from: string          # Images to consider as cache sources
  --cgroup-parent: string       # Optional parent cgroup for the container
  --compress                    # Compress the build context using gzip
  --cpu-period: int             # Limit the CPU CFS (Completely Fair Scheduler) period
  --cpu-quota: int              # Limit the CPU CFS (Completely Fair Scheduler) quota
  --cpu-shares(-c): int         # CPU shares (relative weight)
  --cpuset-cpus: string         # CPUs in which to allow execution (0-3, 0,1)
  --cpuset-mems: string         # MEMs in which to allow execution (0-3, 0,1)
  --disable-content-trust       # Skip image verification (default true)
  --file(-f): string            # Name of the Dockerfile (Default is 'PATH/Dockerfile')
  --force-rm                    # Always remove intermediate containers
  --iidfile: string             # Write the image ID to the file
  --isolation: string           # Container isolation technology
  --label: string               # Set metadata for an image
  --memory(-m): string          # Memory limit
  --memory-swap: string         # Swap limit equal to memory plus swap: '-1' to enable unlimited swap
  --network: string             # Set the networking mode for the RUN instructions during build (default "default")
  --no-cache                    # Do not use cache when building the image
  --output(-o): string          # (1.40+) Output destination (format: type=local,dest=path)
  --platform                    # (1.40+) Set platform if server is multi-platform capable
  --progress: string            # Set type of progress output (auto, plain, tty). Use plain to show container output (default "auto")
  --pull                        # Always attempt to pull a newer version of the image
  --quiet(-q)                   # Suppress the build output and print image ID on success
  --rm                          # Remove intermediate containers after a successful build (default true)
  --secret: string              # Secret file to expose to the build (only if BuildKit enabled): id=mysecret,src=/local/secret
  --security-opt: string        # Security options
  --shm-size: string            # Size of /dev/shm
  --squash                      # Squash newly built layers into a single new layer
  --tag(-t): string             # Name and optionally a tag in the 'name:tag' format
  --target: string              # Set the target build stage to build.
  --ulimit: string              # Ulimit options (default [])
  --help(-h)
  path: string                  # PATH | URL | -
]

# Show the history of an image
export extern "docker image history" [
  --format: string      # Pretty-print images using a Go template
  --human(-H)           # Print sizes and dates in human readable format (default true)
  --no-trunc            # Don't truncate output
  --quiet(-q)           # Only show image IDs
  --help(-h)
  image: string
]

# Import the contents from a tarball to create a filesystem image
export extern "docker image import" [
  --change(-c): list      # Apply Dockerfile instruction to the created image
  --message(-m): string   # Set commit message for imported image
  --platform: string      # Set platform if server is multi-platform capable
  --help(-h)
  file: string            # file|URL|-
  repository?: string     # [REPOSITORY[:TAG]]
]

# Display detailed information on one or more images
export extern "docker image inspect" [
  --format(-f): string # Format the output using the given Go template
  --help(-h)
  ...image: string
]

# Load an image from a tar archive or STDIN
export extern "docker image load" [
  --input(-i): string  # Read from tar archive file, instead of STDIN
  --quiet(-q)          # Suppress the load output
  --help(-h)
]

# List images
export extern "docker image ls" [
  --all(-a)             # Show all images (default hides intermediate images)
  --digests             # Show digests
  --filter(-f): string  # Filter output based on conditions provided
  --format: string      # Pretty-print images using a Go template
  --no-trunc            # Don't truncate output
  --quiet(-q)           # Only show image IDs
  --help(-h)
  repository?: string   # [REPOSITORY[:TAG]]
]

# List images (alias for "docker image ls")
export extern "docker image list" [
  --all(-a)             # Show all images (default hides intermediate images)
  --digests             # Show digests
  --filter(-f): string  # Filter output based on conditions provided
  --format: string      # Pretty-print images using a Go template
  --no-trunc            # Don't truncate output
  --quiet(-q)           # Only show image IDs
  --help(-h)
  repository?: string   # [REPOSITORY[:TAG]]
]

# Remove unused images
export extern "docker image prune" [
  --all(-a)                # Remove all unused images, not just dangling ones
  --filter: string         # Provide filter values (e.g. 'until=<timestamp>')
  --force(-f)              # Do not prompt for confirmation
  --help(-h)
]

# Pull an image or a repository from a registry
export extern "docker image pull" [
  --all-tags(-a)                # Download all tagged images in the repository
  --disable-content-trust       # Skip image verification (default true)
  --platform: string            # Set platform if server is multi-platform capable
  --quiet(-q)                   # Suppress verbose output
  --help(-h)
  image: string                 # NAME[:TAG|@DIGEST]
]

# Push an image or a repository to a registry
export extern "docker image push" [
  --all-tags(-a)                # Push all tagged images in the repository
  --disable-content-trust       # Skip image signing (default true)
  --quiet(-q)                   # Suppress verbose output
  --help(-h)
  image: string                 # NAME[:TAG]
]

# Remove one or more images
export extern "docker image rm" [
  --force(-f)      # Force removal of the image
  --no-prune       # Do not delete untagged parents
  --help(-h)
  ...image: string # IMAGE [IMAGE...]
]

# Remove one or more images (alias for "docker image rm")
export extern "docker image rmi" [
  --force(-f)      # Force removal of the image
  --no-prune       # Do not delete untagged parents
  --help(-h)
  ...image: string # IMAGE [IMAGE...]
]

# Remove one or more images (alias for "docker image rm")
export extern "docker image remove" [
  --force(-f)      # Force removal of the image
  --no-prune       # Do not delete untagged parents
  --help(-h)
  ...image: string # IMAGE [IMAGE...]
]

# Save one or more images to a tar archive (streamed to STDOUT by default)
export extern "docker image save" [
  --output(-o): string   # Write to a file, instead of STDOUT
  --help(-h)
  ...images: string
]

# Create a tag TARGET_IMAGE that refers to SOURCE_IMAGE
export extern "docker image tag" [
  --help(-h)
  source: string # SOURCE_IMAGE[:TAG]
  target: string # TARGET_IMAGE[:TAG]
]

# Remove one or more images (alias for "docker image rm")
export extern "docker rmi" [
  --force(-f)      # Force removal of the image
  --no-prune       # Do not delete untagged parents
  --help(-h)
  ...image: string # IMAGE [IMAGE...]
]