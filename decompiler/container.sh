# Commands to install buildah on Ubuntu 20.04:
#source /etc/os-release
#sudo sh -c "echo 'deb http://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/xUbuntu_${VERSION_ID}/ /' > /etc/apt/sources.list.d/devel:kubic:libcontainers:stable.list"
#wget -nv https://download.opensuse.org/repositories/devel:kubic:libcontainers:stable/xUbuntu_${VERSION_ID}/Release.key -O- | sudo apt-key add -
#sudo apt-get update
#sudo apt-get install buildah

# We're going to base the container on Ubuntu 20.04.
baseimage="docker://ubuntu:20.04"

# Create a new container using the baseimage as a starting point.
container=$(buildah from ${baseimage})

# Install required packages.
buildah run ${container} apt-get update
buildah run ${container} bash -c 'DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends tzdata'
buildah run ${container} apt-get install -y npm
buildah run ${container} apt-get install -y python
buildah run ${container} apt-get install -y curl

# Update npm.
buildah run ${container} npm install -g n
buildah run ${container} n nightly

# Install npm packages.
buildah run ${container} npm install -g typescript
buildah run ${container} npm install -g ts-node
buildah run ${container} npm install -g child_process
buildah run ${container} npm install -g fs
buildah run ${container} npm install -g @types/watch

# Copy scripts into container.
buildah run ${container} mkdir micropython
buildah run ${container} mkdir micropython/tools
buildah copy ${container} 'micropython/tools/makeqstrdata.py' 'micropython/tools/makeqstrdata.py'
buildah copy ${container} 'micropython/tools/mpy-tool.py' 'micropython/tools/mpy-tool.py'
buildah copy ${container} 'disassemble.ts' 'disassemble.ts'
buildah copy ${container} 'decompile.ts' 'decompile.ts'
buildah copy ${container} 'tsconfig.json' 'tsconfig.json'

# Copy the input file(s).
buildah run ${container} mkdir 'in' 
buildah copy ${container} '../filesystem/spike - v1.1.01.0002-3e5a121 - 3.0.1/hub_runtime.mpy' 'in/hub_runtime.mpy'

# Run the disassembler and decompiler.
buildah run ${container} ts-node -T disassemble.ts
buildah run ${container} cat out/hub_runtime.s > hub_runtime.s
buildah run ${container} ts-node -T decompile.ts out/hub_runtime.s > hub_runtime.py

# Clean up the container.
buildah rm ${container}
