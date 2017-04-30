# bman

## Description
show manual page for command such as "ls" on the blowser.

![bman_usage.gif](https://github.com/t-yng/bman/blob/images/images/bman_usge.gif)

## Installation
Please exec `install.sh`  
Symbolic link will be created at `/usr/local/bin`

```
$ git clone https://github.com/t-yng/bman && cd bman
$ sh ./install.sh
```

## Usage
### show manual page

```
$ bman ls
```

### update manual
You can update manual information with `--config`  
The following example, you add the new command and manual page for "awk".

If you input a existed command, the manual page will be updated for the command.

```
$ bman --config
add or update manual
command: awk
url of manual: https://hydrocul.github.io/wiki/commands/awk.html
```

You can update manual information with text editor by editing `manual.json`.
`manual.json` is the setting file has the list of command and manual page url.

```manual.json
{
	"manual": [
		{
			"command": "&",
			"url": "http://itpro.nikkeibp.co.jp//article/COLUMN/20060224/230589/"
		},
		{
			"command": "&&",
			"url": "http://itpro.nikkeibp.co.jp//article/COLUMN/20060224/230604/"
		},

		...
