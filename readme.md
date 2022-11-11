# Go embed

Embed executable file and execute it in memory.

**Example**: https://replit.com/@tranphuquy19/go-embed#readme.md

## Usage

1. Build hello-world binary file to test.

```bash
gcc -o hello-world hello-world.cpp
```

2. Embed hello-world binary file to go file. And build it.

```bash
export CGO_ENABLED=0 # run this command only once
go build .
./go-embed
```

3. Change executable file name to test.

- Update go directive `//go:embed hello-world` to your executable file name (at line 10 in main.go), and build it again.

4. Multi platform support

- Check supported platform list by `go tool dist list`. Copy them to `platforms.txt` file.
- Then run 

```bash
chmod +x build.sh # run this command only once
./build.sh
```

- Check `build` folder, you will see executable file for each platform.