package main

import (
	_ "embed"
	"os"
	"os/exec"
)

//go:embed hello-world
var executableFile []byte

func main() {
	// var eFileName string = os.Getenv("GOOS") == "linux" ? "hello-world" : "hello-world.exe"
	var eFileName string
	if os.Getenv("GOOS") == "linux" {
		eFileName = "hello-world"
	} else {
		eFileName = "hello-world.exe"
	}
	_ = os.WriteFile(eFileName, executableFile, 0755)
	out, _ := exec.Command("./" + eFileName).Output()
	println(string(out))
}
